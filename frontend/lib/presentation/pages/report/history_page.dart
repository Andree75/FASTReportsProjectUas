import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/report_provider.dart';
import '../../../core/constants/api_constants.dart';
import '../../../domain/entities/report.dart';
import 'detail_report_page.dart';
import 'report_printer_helper.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int? userId;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('user_id') != null) {
      setState(() => userId = prefs.getInt('user_id'));
      Provider.of<ReportProvider>(context, listen: false).fetchHistory(userId!);
    }
  }

  Color _urgencyColor(String l) =>
      {'DARURAT': Colors.red, 'TINGGI': Colors.orange, 'SEDANG': Colors.blue}[l
          .toUpperCase()] ??
      Colors.green;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Diproses':
        return Colors.blue;
      case 'Ditindak Lanjuti':
        return Colors.purple;
      case 'Selesai':
        return Colors.green;
      case 'Ditolak':
        return Colors.red;
      case 'Ditangguhkan':
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  void _print(Report r) async {
    try {
      final p = await ReportPrinterHelper.exportToTxt(r);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Disimpan: $p"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F8),
      appBar: AppBar(
        title: Text(
          "Riwayat Laporan",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD32F2F), Color(0xFFFF7043)],
            ),
          ),
        ),
      ),
      body: Consumer<ReportProvider>(
        builder: (ctx, prov, _) {
          if (prov.isLoading) return Center(child: CircularProgressIndicator());
          if (prov.reports.isEmpty)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 60, color: Colors.grey),
                  Text("Belum ada riwayat"),
                ],
              ),
            );

          return RefreshIndicator(
            onRefresh: () async =>
                userId != null ? await prov.fetchHistory(userId!) : null,
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: prov.reports.length,
              itemBuilder: (context, i) => _reportCard(prov.reports[i]),
            ),
          );
        },
      ),
    );
  }

  Widget _reportCard(Report r) {
    final statusColor = _getStatusColor(r.status);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailReportPage(report: r)),
          ).then((_) => _initData()),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "${ApiConstants.imageBaseUrl}/${r.imagePath}",
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey[200],
                      child: Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              r.category.toUpperCase(),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: _urgencyColor(r.urgency),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        r.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        r.createdAt,
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: statusColor.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          "Status: ${r.status}",
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.print_outlined, color: Colors.blue[700]),
                  onPressed: () => _print(r),
                  style: IconButton.styleFrom(backgroundColor: Colors.blue[50]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

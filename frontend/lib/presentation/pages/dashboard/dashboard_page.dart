import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/report_provider.dart';
import '../../../core/constants/api_constants.dart';
import '../../widgets/custom_drawer.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int? userId;
  String userName = "User";

  final List<Map<String, dynamic>> _cats = [
    {
      'icon': Icons.back_hand_rounded,
      'label': 'Kekerasan Fisik',
      'color': Colors.redAccent,
    },
    {
      'icon': Icons.privacy_tip_rounded,
      'label': 'Pelecehan',
      'color': Colors.purpleAccent,
    },
    {
      'icon': Icons.lock_person_rounded,
      'label': 'Pencurian',
      'color': Colors.orangeAccent,
    },
    {
      'icon': Icons.medication_rounded,
      'label': 'Narkoba',
      'color': Colors.blueAccent,
    },
    {
      'icon': Icons.minor_crash_rounded,
      'label': 'Kecelakaan',
      'color': Colors.brown,
    },
    {'icon': Icons.smartphone_rounded, 'label': 'Judol', 'color': Colors.teal},
    {'icon': Icons.campaign_rounded, 'label': 'Lainnya', 'color': Colors.grey},
  ];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('user_id') == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }
    setState(() {
      userId = prefs.getInt('user_id');
      userName = prefs.getString('full_name') ?? "User";
    });
    if (mounted) {
      Provider.of<ReportProvider>(context, listen: false).fetchHistory(userId!);
    }
  }

  void _goCreate(String cat) {
    Navigator.pushNamed(context, '/create_report', arguments: cat).then((v) {
      if (v == true && userId != null) {
        Provider.of<ReportProvider>(
          context,
          listen: false,
        ).fetchHistory(userId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F8),
      appBar: AppBar(
        title: Text(
          "Fast Reports",
          style: TextStyle(fontWeight: FontWeight.w800),
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
      drawer: CustomDrawer(),
      body: Consumer<ReportProvider>(
        builder: (ctx, prov, _) => RefreshIndicator(
          onRefresh: () async =>
              userId != null ? await prov.fetchHistory(userId!) : null,
          child: ListView(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
            children: [
              Text(
                "Halo, $userName! 👋",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Text(
                "Laporkan kejadian di sekitarmu.",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              SizedBox(height: 25),
              Text(
                "Buat Quick Reports :",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                ),
                itemCount: _cats.length,
                itemBuilder: (c, i) => _catBtn(_cats[i]),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Report",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    child: Text("Lihat Semua"),
                  ),
                ],
              ),

              if (prov.isLoading)
                Center(child: CircularProgressIndicator())
              else if (prov.reports.isEmpty)
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "Belum ada laporan aktif.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                _reportCard(prov.reports.first),
            ],
          ),
        ),
      ),
    );
  }

  Widget _catBtn(Map<String, dynamic> item) {
    // Casting agar aman
    final Color color = item['color'] as Color;
    final String label = item['label'] as String;
    final IconData icon = item['icon'] as IconData;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _goCreate(label),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.6), color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _reportCard(var r) {
    return Container(
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

          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
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
                      color: Colors.grey[100],
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          r.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        r.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        r.createdAt,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

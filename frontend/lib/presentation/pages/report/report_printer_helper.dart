import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../../domain/entities/report.dart';

class ReportPrinterHelper {
  static Future<String> exportToTxt(Report report) async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
    } else {
      directory = await getDownloadsDirectory();
    }

    if (directory == null) throw "Folder Downloads tidak ditemukan";
    final fileName =
        "Laporan_${report.category}_${DateTime.now().millisecondsSinceEpoch}.txt";
    final path = "${directory.path}/$fileName";
    final file = File(path);

    StringBuffer buffer = StringBuffer();
    String lineDouble = "==================================================";
    String lineSingle = "--------------------------------------------------";
    buffer.writeln(lineDouble);
    buffer.writeln("          BUKTI LAPORAN - FAST REPORTS");
    buffer.writeln(lineDouble);
    buffer.writeln("");
    buffer.writeln("WAKTU CETAK : ${DateTime.now().toString().split('.')[0]}");
    buffer.writeln("ID LAPORAN  : #${report.id}");
    buffer.writeln("TANGGAL     : ${report.createdAt}");
    buffer.writeln("KATEGORI    : ${report.category.toUpperCase()}");
    buffer.writeln("URGENSI     : [ ${report.urgency.toUpperCase()} ]");
    buffer.writeln("");
    buffer.writeln("DETAIL INFORMASI");
    buffer.writeln(lineSingle);

    if (report.metadata != null &&
        report.metadata != "{}" &&
        report.metadata!.isNotEmpty) {
      try {
        Map<String, dynamic> meta = jsonDecode(report.metadata!);
        meta.forEach((key, value) {
          String label = key.replaceAll('_', ' ').toUpperCase();
          buffer.writeln("${label} : $value");
        });
      } catch (_) {
        buffer.writeln("Data detail tidak dapat dibaca.");
      }
    } else {
      buffer.writeln("- Tidak ada informasi tambahan -");
    }
    buffer.writeln("");
    buffer.writeln("KRONOLOGI KEJADIAN");
    buffer.writeln(lineSingle);
    buffer.writeln(report.description);
    buffer.writeln("");
    buffer.writeln(lineDouble);
    buffer.writeln("       TERIMAKASIH ATAS LAPORAN ANDA");
    buffer.writeln("      Simpan dokumen ini sebagai bukti.");
    buffer.writeln(lineDouble);

    await file.writeAsString(buffer.toString());

    return path;
  }
}

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LinuxCameraHelper {
  static Future<File> capturePhoto() async {
    try {
      final directory = await getTemporaryDirectory();
      final fileName = 'linux_cam_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = path.join(directory.path, fileName);
      final result = await Process.run('fswebcam', [
        '-r',
        '1280x720',
        '--jpeg',
        '85',
        '--no-banner',
        '-S',
        '2',
        filePath,
      ]);
      if (result.exitCode == 0) {
        return File(filePath);
      } else {
        throw Exception(
          "Gagal fswebcam: ${result.stderr}. Modul kamera tidak terbaca",
        );
      }
    } catch (e) {
      throw Exception("Error Linux Helper: $e");
    }
  }
}

class ApiConstants {
  // Jika pakai emulator android studio Pakai IP bawaan emulator ContD
  static const String serverIp = "localhost";
  static const String baseUrl = "http://$serverIp/fast_api";
  static const String imageBaseUrl = baseUrl;
  static const String loginEndpoint = "$baseUrl/login.php";
  static const String registerEndpoint = "$baseUrl/register.php";
  static const String uploadReportEndpoint = "$baseUrl/upload_report.php";
  static const String getHistoryEndpoint = "$baseUrl/get_history.php";
  static const String deleteReportEndpoint = "$baseUrl/delete_report.php";
  static const String adminLoginEndpoint = "$baseUrl/admin_login.php";
  static const String updateStatusEndpoint = "$baseUrl/update_status.php";
}

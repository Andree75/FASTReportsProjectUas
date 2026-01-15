import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasources/auth_local_datasource.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/report_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/auth/register_page.dart';
import 'presentation/pages/dashboard/dashboard_page.dart';
import 'presentation/pages/report/create_report_page.dart';
import 'data/repositories/report_repository_impl.dart';
import 'presentation/providers/report_provider.dart';
import 'presentation/pages/report/history_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final http.Client httpClient = http.Client();
  final sharedPreferences = await SharedPreferences.getInstance();

  final authRemote = AuthRemoteDataSourceImpl(client: httpClient);
  final authLocal = AuthLocalDataSourceImpl(
    sharedPreferences: sharedPreferences,
  );
  final authRepo = AuthRepositoryImpl(
    remoteDataSource: authRemote,
    localDataSource: authLocal,
  );

  final reportRemote = ReportRemoteDataSourceImpl(client: httpClient);
  final reportRepo = ReportRepositoryImpl(remoteDataSource: reportRemote);
  final bool isLoggedIn = await authRepo.checkLoginStatus();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(repository: authRepo),
        ),
        ChangeNotifierProvider(
          create: (_) => ReportProvider(repository: reportRepo),
        ),
      ],
      child: MaterialApp(
        title: 'Fast Reports',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: isLoggedIn ? '/dashboard' : '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/dashboard': (context) => DashboardPage(),
          '/create_report': (context) => CreateReportPage(),
          '/history': (context) => HistoryPage(),
        },
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'admin_screens/splash_screen.dart';
import 'admin_screens/login_screen.dart';
import 'admin_screens/register_screen.dart';
import 'admin_screens/dashboard_screen.dart';
import 'admin_screens/data_barang_screen.dart';
import 'admin_screens/tambah_barang_screen.dart';
import 'admin_screens/data_user_screen.dart';
import 'theme/app_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PinjamDapur',
      theme: ThemeData(
        primaryColor: AppColor.primary,
        scaffoldBackgroundColor: AppColor.background,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/data-barang': (context) => const DataBarangScreen(),
        '/tambah-barang': (context) => const TambahBarangScreen(),
        '/data-user': (context) => const DataUserScreen(),


      },
    );
  }
}

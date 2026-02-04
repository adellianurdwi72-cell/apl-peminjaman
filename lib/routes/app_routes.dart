import 'package:flutter/material.dart';
import 'route_names.dart';

// screens
import '../screens/dashboard_screen.dart';
import '../screens/data_user_screen.dart';
import '../screens/peminjaman_screen.dart';
import '../screens/pengembalian_screen.dart';
import '../screens/logout_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    RouteNames.dashboard: (context) => const DashboardScreen(),
    RouteNames.dataUser: (context) => const DataUserScreen(), // 🔥 INI KUNCI
    RouteNames.peminjaman: (context) => const PeminjamanScreen(),
    RouteNames.pengembalian: (context) => const PengembalianScreen(),
    RouteNames.logout: (context) => const LogoutScreen(),
  };
}

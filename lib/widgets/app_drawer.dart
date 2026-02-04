import 'package:flutter/material.dart';
import '../routes/route_names.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _go(BuildContext context, String route) {
    debugPrint("Navigasi ke: $route");
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Text(
              'PinjamDapur',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          _item(context, Icons.dashboard, 'Dashboard', RouteNames.dashboard),
          _item(context, Icons.people, 'Data User', RouteNames.dataUser),
          _item(context, Icons.assignment, 'Peminjaman', RouteNames.peminjaman),
          _item(
            context,
            Icons.assignment_return,
            'Pengembalian',
            RouteNames.pengembalian,
          ),
          _item(context, Icons.logout, 'Keluar', RouteNames.logout),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => _go(context, route),
    );
  }
}

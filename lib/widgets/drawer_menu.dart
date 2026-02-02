import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';
import '../screens/data_barang_screen.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                "PINJAM BARANG",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          drawerItem(context, "Dashboard", const DashboardScreen()),
          drawerItem(context, "Data Barang", const DataBarangScreen()),
        ],
      ),
    );
  }

  Widget drawerItem(BuildContext context, String title, Widget page) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }
}

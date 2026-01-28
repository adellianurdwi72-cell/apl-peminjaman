import 'package:flutter/material.dart';
import '../../theme/app_color.dart';

class DataUserScreen extends StatelessWidget {
  const DataUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data User'),
        backgroundColor: AppColor.primary,
      ),
      drawer: _buildDrawer(context),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // SEARCH
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari Pengguna...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                children: [
                  _sectionTitle('Admin'),
                  _userTile('Raib', 'raib@gmail.com'),

                  _sectionTitle('Petugas'),
                  _userTile('Seli', 'seli@gmail.com'),
                  _userTile('Eko', 'eko@gmail.com'),

                  _sectionTitle('Pengguna'),
                  _userTile('Citra', 'citra@gmail.com'),
                  _userTile('Dina', 'dina@gmail.com'),
                  _userTile('Budi', 'budi@gmail.com'),
                  _userTile('Fani', 'fani@gmail.com'),
                  _userTile('Gilang', 'gilang@gmail.com'),
                  _userTile('Ali', 'ali@gmail.com'),
                  _userTile('Hana', 'hana@gmail.com'),
                  _userTile('Akram', 'akram@gmail.com'),
                  _userTile('Adzkiya', 'adzkiya@gmail.com'),
                  _userTile('Elvano', 'elvano@gmail.com'),
                  _userTile('Alisya', 'alisya@gmail.com'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 SECTION TITLE
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // 🔹 USER TILE
  Widget _userTile(String name, String email) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColor.softGreen,
          child: Icon(Icons.person, color: Colors.black),
        ),
        title: Text(name),
        subtitle: Text(email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.edit, color: Colors.orange),
            SizedBox(width: 8),
            Icon(Icons.delete, color: Colors.red),
          ],
        ),
      ),
    );
  }

  // 🔹 DRAWER
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColor.primary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.soup_kitchen, size: 60, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  'PINJAMDAPUR',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          _drawerItem(context, Icons.dashboard, 'Dashboard', '/dashboard'),
          _drawerItem(context, Icons.inventory, 'Data Barang', '/data-barang'),
          _drawerItem(context, Icons.people, 'Data User', '/data-user'),
          _drawerItem(context, Icons.assignment, 'Peminjaman', '/peminjaman'),
          _drawerItem(context, Icons.assignment_return, 'Pengembalian', '/pengembalian'),
          const Spacer(),
          _drawerItem(context, Icons.logout, 'Keluar', '/login'),
        ],
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}

import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFCDE3B3)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(radius: 35, backgroundColor: Colors.white),
                SizedBox(height: 10),
                Text(
                  'PINJAM DAPUR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _item(Icons.dashboard, 'Dashboard'),
          _item(Icons.inventory, 'Data Barang'),
          _item(Icons.people, 'Data User'),
          _item(Icons.assignment, 'Peminjaman'),
          _item(Icons.assignment_return, 'Pengembalian'),
          const Divider(),
          _item(Icons.logout, 'Keluar'),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: () {});
  }
}

import 'package:flutter/material.dart';
import '../../theme/app_color.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text('Dashboard'),
      ),

      // ================= DRAWER =================
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.soup_kitchen, size: 60, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'PINJAMDAPUR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 DASHBOARD
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // 🔹 DATA BARANG
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Data Barang'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/data-barang');
              },
            ),

            // 🔹 DATA USER (DIGABUNG)
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Data User'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/data-user');
              },
            ),

            const Spacer(),

            // 🔹 LOGOUT
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Keluar'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),

      // ================= BODY DASHBOARD =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoCard('Total Pinjaman', '687'),
                _infoCard('Total Pengguna', '439'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoCard('Barang Tersedia', '80'),
                _infoCard('Barang Dipinjam', '120'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.softGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

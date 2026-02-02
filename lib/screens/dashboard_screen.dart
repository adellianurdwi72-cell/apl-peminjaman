import 'package:flutter/material.dart';

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
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF4F1E8),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F1E8),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// STATISTIK
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: const [
                InfoCard(title: "Total Pinjaman", value: "35"),
                InfoCard(title: "Total Pengguna", value: "12"),
                InfoCard(title: "Barang Tersedia", value: "14"),
                InfoCard(title: "Barang Dipinjam", value: "5"),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              "Peminjaman Terbaru",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            const PeminjamanItem(
              nama: "Fani",
              barang: "Timbangan digital",
              status: "Menunggu",
            ),
            const PeminjamanItem(
              nama: "Citra",
              barang: "Sepatu",
              status: "Disetujui",
            ),
            const PeminjamanItem(
              nama: "Budi",
              barang: "Oven",
              status: "Disetujui",
            ),
            const PeminjamanItem(
              nama: "Hana",
              barang: "Cetakan kue",
              status: "Menunggu",
            ),
            const PeminjamanItem(
              nama: "Dina",
              barang: "Whisk",
              status: "Menunggu",
            ),
          ],
        ),
      ),
    );
  }
}

/// CARD STATISTIK
class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

/// LIST PEMINJAMAN
class PeminjamanItem extends StatelessWidget {
  final String nama;
  final String barang;
  final String status;

  const PeminjamanItem({
    super.key,
    required this.nama,
    required this.barang,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isMenunggu = status == "Menunggu";

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Peminjam : $nama"),
          Text("Barang   : $barang"),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(
                label: Text(
                  status,
                  style: TextStyle(
                    color: isMenunggu ? Colors.orange : Colors.green,
                  ),
                ),
                backgroundColor: isMenunggu
                    ? Colors.orange.shade50
                    : Colors.green.shade50,
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                onPressed: () {},
                child: const Text("Setuju"),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                onPressed: () {},
                child: const Text("Tolak"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// DRAWER MENU
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.store, color: Colors.white, size: 40),
                ),
                SizedBox(height: 8),
                Text(
                  "PINJAM BARANG",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          drawerItem(Icons.dashboard, "Dashboard"),
          drawerItem(Icons.inventory, "Data Barang"),
          drawerItem(Icons.people, "Data User"),
          drawerItem(Icons.assignment, "Peminjaman"),
          drawerItem(Icons.assignment_return, "Pengembalian"),
          drawerItem(Icons.logout, "Keluar"),
        ],
      ),
    );
  }

  Widget drawerItem(IconData icon, String title) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: () {});
  }
}

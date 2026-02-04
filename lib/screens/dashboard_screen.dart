import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/peminjaman_tile.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DASHBOARD BARU',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: const [
                  DashboardCard(title: 'Total Peminjam', value: '35'),
                  DashboardCard(title: 'Total Pengguna', value: '12'),
                  DashboardCard(title: 'Barang Tersedia', value: '14'),
                  DashboardCard(title: 'Barang Dipinjam', value: '5'),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                'Peminjaman Terbaru',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              PeminjamanTile(
                nama: 'Fani',
                barang: 'Timbangan digital',
                status: 'Menunggu',
              ),
              PeminjamanTile(
                nama: 'Citra',
                barang: 'Spatula',
                status: 'Disetujui',
              ),
              PeminjamanTile(nama: 'Budi', barang: 'Oven', status: 'Disetujui'),
            ],
          ),
        ),
      ),
    );
  }
}

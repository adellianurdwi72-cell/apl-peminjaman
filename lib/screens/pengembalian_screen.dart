import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/info_card.dart';

class PengembalianScreen extends StatelessWidget {
  const PengembalianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Pengembalian'),
        backgroundColor: const Color(0xFFE6E1C7),
        elevation: 0,
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// USER INFO
            InfoCard(
              title: 'Citra',
              subtitle: 'Pekerja rumah makan',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Tgl pinjam : 2 Januari 2026'),
                  Text('Rencana pengembalian : 6 Januari 2026'),
                  Text('Tgl pengembalian : 9 Januari 2026'),
                ],
              ),
            ),

            /// LAPORAN PEMINJAM
            InfoCard(
              title: 'Laporan Kondisi (Peminjam)',
              color: Colors.orange,
              child: const Text('Rusak\nGagang spatula patah'),
            ),

            /// HASIL PETUGAS
            InfoCard(
              title: 'Hasil Pengecekan Petugas',
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Kondisi Akhir : Rusak'),
                  SizedBox(height: 6),
                  Text('Denda Keterlambatan : Rp 30.000'),
                  Text('Denda Kerusakan : Rp 15.000'),
                  Divider(),
                  Text(
                    'Total Denda : Rp 45.000',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            /// STATUS ADMIN
            InfoCard(
              title: 'Status Administrasi',
              color: Colors.orange,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Di Catat'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    onPressed: () {},
                    child: const Text('Tandai Selesai'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

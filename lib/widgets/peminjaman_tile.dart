import 'package:flutter/material.dart';

class PeminjamanTile extends StatelessWidget {
  final String nama;
  final String barang;
  final String status;

  const PeminjamanTile({
    super.key,
    required this.nama,
    required this.barang,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Peminjam : $nama'),
            Text('Barang : $barang'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(status),
                  backgroundColor: status == 'Disetujui'
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                ),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text('Setujui')),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Tolak',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

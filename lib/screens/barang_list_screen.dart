import 'package:flutter/material.dart';

class BarangListScreen extends StatelessWidget {
  final String kategori;
  const BarangListScreen({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(kategori, style: const TextStyle(color: Colors.black)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          BarangItem(nama: "Pisau", status: "Tersedia"),
          BarangItem(nama: "Whisk", status: "Dipinjam"),
          BarangItem(nama: "Sendok Takar", status: "Tersedia"),
          BarangItem(nama: "Blow Torch", status: "Dipinjam"),
        ],
      ),
    );
  }
}

class BarangItem extends StatelessWidget {
  final String nama;
  final String status;

  const BarangItem({super.key, required this.nama, required this.status});

  @override
  Widget build(BuildContext context) {
    final tersedia = status == "Tersedia";

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.inventory),
          const SizedBox(width: 12),
          Expanded(child: Text(nama)),
          CircleAvatar(
            radius: 6,
            backgroundColor: tersedia ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }
}

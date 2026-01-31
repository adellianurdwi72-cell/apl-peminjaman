import 'package:flutter/material.dart';
import 'peminjaman_form_screen.dart';

class Peminjaman {
  String nama;
  String barang;
  String tanggal;
  String status;

  Peminjaman({
    required this.nama,
    required this.barang,
    required this.tanggal,
    required this.status,
  });
}

class PeminjamanScreen extends StatefulWidget {
  const PeminjamanScreen({super.key});

  @override
  State<PeminjamanScreen> createState() => _PeminjamanScreenState();
}

class _PeminjamanScreenState extends State<PeminjamanScreen> {
  final List<Peminjaman> list = [
    Peminjaman(
      nama: "Hana",
      barang: "Cetakan Kue",
      tanggal: "8–12 Januari 2026",
      status: "Selesai",
    ),
    Peminjaman(
      nama: "Fani",
      barang: "Timbangan Digital",
      tanggal: "6–10 Januari 2026",
      status: "Disetujui",
    ),
    Peminjaman(
      nama: "Budi",
      barang: "Oven",
      tanggal: "2–6 Januari 2026",
      status: "Dipending",
    ),
    Peminjaman(
      nama: "Citra",
      barang: "Spatula",
      tanggal: "3–9 Januari 2026",
      status: "Terlambat",
    ),
  ];

  Color _statusColor(String status) {
    switch (status) {
      case "Selesai":
        return Colors.blue;
      case "Disetujui":
        return Colors.green;
      case "Dipending":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EEDC),
      appBar: AppBar(
        title: const Text("Peminjaman"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB7D2A3),
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push<Peminjaman>(
            context,
            MaterialPageRoute(
              builder: (_) => const PeminjamanFormScreen(),
            ),
          );
          if (result != null) {
            setState(() => list.add(result));
          }
        },
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final data = list[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    data.nama[0],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.nama,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Chip(
                            label: Text(
                              data.status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            backgroundColor:
                                _statusColor(data.status),
                          ),
                        ],
                      ),
                      Text(data.barang),
                      const SizedBox(height: 4),
                      Text(
                        data.tanggal,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == "hapus") {
                      setState(() => list.removeAt(index));
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: "hapus",
                      child: Text("Hapus"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/barang_service.dart';
import 'tambah_barang_screen.dart';

class BarangListScreen extends StatefulWidget {
  final String kategoriId;
  final String title;

  const BarangListScreen({
    super.key,
    required this.kategoriId,
    required this.title,
  });

  @override
  State<BarangListScreen> createState() => _BarangListScreenState();
}

class _BarangListScreenState extends State<BarangListScreen> {
  final service = BarangService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAE6CF),
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TambahBarangScreen(kategoriId: widget.kategoriId),
            ),
          );
          if (result == true) setState(() {});
        },
      ),
      body: FutureBuilder(
        future: service.getBarang(widget.kategoriId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final list = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final b = list[index];

              return ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                title: Text(b['nama']),
                subtitle: Text("Stok: ${b['stok']} • ${b['status']}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await service.hapusBarang(b['id']);
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

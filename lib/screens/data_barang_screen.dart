import 'package:flutter/material.dart';
import '../models/barang_model.dart';
import '../services/barang_services.dart';

class DataBarangScreen extends StatefulWidget {
  const DataBarangScreen({super.key});

  @override
  State<DataBarangScreen> createState() => _DataBarangScreenState();
}

class _DataBarangScreenState extends State<DataBarangScreen> {
  final barangService = BarangService();
  List<Barang> barangList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadBarang();
  }

  Future<void> loadBarang() async {
  setState(() => loading = true);

  try {
    final data = await barangService.getBarang(); 
    // Misal data dari Supabase berbentuk List<Map<String, dynamic>>
    setState(() {
      barangList = data.map((item) => Barang.fromMap(item)).toList();
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal memuat data barang: $e')),
    );
  } finally {
    setState(() => loading = false);
  }
}


  void _hapusBarang(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Barang"),
        content: const Text("Yakin ingin menghapus barang ini?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          TextButton(
            onPressed: () async {
              await barangService.hapusBarang(id);
              Navigator.pop(context);
              loadBarang();
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void showForm({Barang? barang}) {
    final namaCtrl = TextEditingController(text: barang?.nama ?? '');
    final stokCtrl = TextEditingController(text: barang?.stok.toString() ?? '');
    final kondisiCtrl = TextEditingController(text: barang?.kondisi ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(barang == null ? "Tambah Barang" : "Edit Barang"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: namaCtrl, decoration: const InputDecoration(labelText: "Nama Barang")),
            TextField(
              controller: stokCtrl,
              decoration: const InputDecoration(labelText: "Stok"),
              keyboardType: TextInputType.number,
            ),
            TextField(controller: kondisiCtrl, decoration: const InputDecoration(labelText: "Kondisi")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            onPressed: () async {
              final nama = namaCtrl.text.trim();
              final stok = int.tryParse(stokCtrl.text.trim()) ?? 0;
              final kondisi = kondisiCtrl.text.trim();

              if (nama.isEmpty || kondisi.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Nama dan kondisi tidak boleh kosong")),
                );
                return;
              }

              try {
                if (barang == null) {
                  await barangService.tambahBarang(
                    nama: nama,
                    stok: stok,
                    kondisi: kondisi,
                    status: "Tersedia",
                  );
                } else {
                  await barangService.updateBarang(
                    id: barang.id,
                    nama: nama,
                    stok: stok,
                    kondisi: kondisi,
                    status: barang.status,
                  );
                }

                Navigator.pop(context); // tutup dialog
                loadBarang(); // refresh list
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Gagal menyimpan barang: $e")),
                );
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  Widget _barangItem(Barang barang, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(barang.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text("Stok: ${barang.stok}"),
              Text("Kondisi: ${barang.kondisi}"),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.orange),
                onPressed: () => showForm(barang: barang),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _hapusBarang(barang.id),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Barang"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF0B45B),
        child: const Icon(Icons.add),
        onPressed: () => showForm(),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: barangList.length,
              itemBuilder: (context, index) {
                return _barangItem(barangList[index], index);
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/barang_model.dart';
import '../services/barang_service.dart';

class FormBarangScreen extends StatefulWidget {
  final Barang? barang;
  final String kategoriId;

  const FormBarangScreen({super.key, this.barang, required this.kategoriId});

  @override
  State<FormBarangScreen> createState() => _FormBarangScreenState();
}

class _FormBarangScreenState extends State<FormBarangScreen> {
  final barangService = BarangService();

  late TextEditingController namaCtrl;
  late TextEditingController stokCtrl;

  String status = 'tersedia';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    namaCtrl = TextEditingController(text: widget.barang?.nama ?? '');
    stokCtrl = TextEditingController(
      text: widget.barang?.stok.toString() ?? '',
    );
    status = widget.barang?.status ?? 'tersedia';
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.barang != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Barang" : "Tambah Barang")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaCtrl,
              decoration: const InputDecoration(labelText: 'Nama Barang'),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: stokCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Stok'),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField(
              value: status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: const [
                DropdownMenuItem(value: 'tersedia', child: Text('Tersedia')),
                DropdownMenuItem(value: 'menipis', child: Text('Stok Menipis')),
                DropdownMenuItem(value: 'habis', child: Text('Stok Habis')),
              ],
              onChanged: (v) => setState(() => status = v!),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: loading ? null : _simpan,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _simpan() async {
    final nama = namaCtrl.text.trim();
    final stok = int.tryParse(stokCtrl.text.trim()) ?? 0;

    if (nama.isEmpty) return;

    setState(() => loading = true);

    try {
      if (widget.barang == null) {
        // ➕ TAMBAH BARANG
        await barangService.tambahBarang(
          nama: nama,
          kategoriId: widget.kategoriId,
          stok: stok,
          status: status,
        );
      } else {
        // ✏️ UPDATE BARANG
        await barangService.updateBarang(
          id: widget.barang!.id,
          nama: nama,
          stok: stok,
          status: status,
        );
      }

      Navigator.pop(context, true); // tanda sukses
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
    } finally {
      setState(() => loading = false);
    }
  }
}

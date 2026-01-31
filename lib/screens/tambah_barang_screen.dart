import 'package:apl_peminjaman_barang/services/barang_services.dart';
import 'package:flutter/material.dart';
import '../models/barang_model.dart';

class TambahBarangScreen extends StatefulWidget {
  final Map<String, dynamic>? barang; // barang dari Supabase (jika edit)
  const TambahBarangScreen({super.key, this.barang});

  @override
  State<TambahBarangScreen> createState() => _TambahBarangScreenState();
}

class _TambahBarangScreenState extends State<TambahBarangScreen> {
  final barangService = BarangService();

  final namaController = TextEditingController();
  final kategoriController = TextEditingController();
  final jumlahController = TextEditingController();
  final statusController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      namaController.text = widget.barang!['nama_barang'] ?? '';
      kategoriController.text = widget.barang!['kategori'] ?? '';
      jumlahController.text = widget.barang!['stok']?.toString() ?? '';
      statusController.text = widget.barang!['status_barang'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.barang != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF3EEDC),
      appBar: AppBar(
        title: Text(isEdit ? "Edit Barang" : "Tambah Barang"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input("Nama Barang", namaController),
            _input("Kategori", kategoriController),
            _input("Jumlah", jumlahController, keyboardType: TextInputType.number),
            _input("Status", statusController),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF0B45B)),
                    onPressed: loading ? null : _simpan,
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Simpan"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _simpan() async {
    final nama = namaController.text.trim();
    final kategori = kategoriController.text.trim();
    final jumlah = jumlahController.text.trim();
    final status = statusController.text.trim();

    if (nama.isEmpty || kategori.isEmpty || jumlah.isEmpty || status.isEmpty) return;

    setState(() => loading = true);

    try {
      if (widget.barang == null) {
        // Tambah Barang Baru
        await barangService.tambahBarang(
          nama: nama,
          stok: int.parse(jumlah),
          kondisi: kategori,
          status: status,
        );
      } else {
        // Update Barang
        await barangService.updateBarang(
          id: widget.barang!['barang_id'],
          nama: nama,
          stok: int.parse(jumlah),
          kondisi: kategori,
          status: status,
        );
      }

      Navigator.pop(context, true); // kirim tanda berhasil
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan barang: $e')),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  Widget _input(String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

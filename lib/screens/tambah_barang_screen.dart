import 'package:flutter/material.dart';
import '../services/barang_service.dart';

class TambahBarangScreen extends StatefulWidget {
  final String kategoriId;
  final Map<String, dynamic>? barang;

  const TambahBarangScreen({super.key, required this.kategoriId, this.barang});

  @override
  State<TambahBarangScreen> createState() => _TambahBarangScreenState();
}

class _TambahBarangScreenState extends State<TambahBarangScreen> {
  final barangService = BarangService();

  final namaController = TextEditingController();
  final jumlahController = TextEditingController();

  String status = 'tersedia';
  bool loading = false;

  @override
  void initState() {
    super.initState();

    if (widget.barang != null) {
      namaController.text = widget.barang!['nama'] ?? '';
      jumlahController.text = widget.barang!['stok']?.toString() ?? '';
      status = widget.barang!['status'] ?? 'tersedia';
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    jumlahController.dispose();
    super.dispose();
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
            _input(
              "Jumlah Stok",
              jumlahController,
              keyboardType: TextInputType.number,
            ),

            DropdownButtonFormField<String>(
              value: status,
              decoration: const InputDecoration(
                labelText: "Status",
                filled: true,
                fillColor: Colors.white,
              ),
              items: const [
                DropdownMenuItem(value: 'tersedia', child: Text('Tersedia')),
                DropdownMenuItem(value: 'menipis', child: Text('Stok Menipis')),
                DropdownMenuItem(value: 'habis', child: Text('Stok Habis')),
              ],
              onChanged: (v) => setState(() => status = v!),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0B45B),
                    ),
                    onPressed: loading ? null : _simpan,
                    child: loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
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
    final stok = int.tryParse(jumlahController.text.trim());

    if (nama.isEmpty || stok == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data tidak valid')));
      return;
    }

    setState(() => loading = true);

    try {
      if (widget.barang == null) {
        await barangService.tambahBarang(
          nama: nama,
          kategoriId: widget.kategoriId,
          stok: stok,
          status: status,
        );
      } else {
        await barangService.updateBarang(
          id: widget.barang!['id'],
          nama: nama,
          stok: stok,
          status: status,
        );
      }

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
    } finally {
      setState(() => loading = false);
    }
  }

  Widget _input(
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
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

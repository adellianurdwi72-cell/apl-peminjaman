import 'package:flutter/material.dart';
import 'peminjaman_screen.dart';

class PeminjamanFormScreen extends StatefulWidget {
  const PeminjamanFormScreen({super.key});

  @override
  State<PeminjamanFormScreen> createState() =>
      _PeminjamanFormScreenState();
}

class _PeminjamanFormScreenState extends State<PeminjamanFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final barangController = TextEditingController();
  final tanggalController = TextEditingController();

  String status = "Dipending";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Peminjaman"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: "Nama"),
                validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: barangController,
                decoration:
                    const InputDecoration(labelText: "Barang"),
                validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: tanggalController,
                decoration:
                    const InputDecoration(labelText: "Tanggal"),
                validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
              ),
              DropdownButtonFormField(
                value: status,
                items: const [
                  DropdownMenuItem(
                      value: "Dipending", child: Text("Dipending")),
                  DropdownMenuItem(
                      value: "Disetujui", child: Text("Disetujui")),
                  DropdownMenuItem(
                      value: "Selesai", child: Text("Selesai")),
                ],
                onChanged: (v) => setState(() => status = v!),
                decoration: const InputDecoration(labelText: "Status"),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7D2A3),
                  minimumSize:
                      const Size(double.infinity, 45),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      Peminjaman(
                        nama: namaController.text,
                        barang: barangController.text,
                        tanggal: tanggalController.text,
                        status: status,
                      ),
                    );
                  }
                },
                child: const Text("Simpan"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

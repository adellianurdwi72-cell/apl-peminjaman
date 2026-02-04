import 'package:supabase_flutter/supabase_flutter.dart';

class BarangService {
  final _db = Supabase.instance.client;

  // 🔹 Ambil kategori
  Future<List<Map<String, dynamic>>> getKategori() async {
    return await _db.from('kategori').select().order('nama');
  }

  // 🔹 Ambil barang per kategori
  Future<List<Map<String, dynamic>>> getBarang(String kategoriId) async {
    return await _db
        .from('barang')
        .select()
        .eq('kategori_id', kategoriId)
        .order('nama');
  }

  // ➕ Tambah barang
  Future<void> tambahBarang({
    required String nama,
    required String kategoriId,
    required int stok,
    required String status,
  }) async {
    await _db.from('barang').insert({
      'nama': nama,
      'kategori_id': kategoriId,
      'stok': stok,
      'status': status,
    });
  }

  // ✏️ Update barang
  Future<void> updateBarang({
    required String id,
    required String nama,
    required int stok,
    required String status,
  }) async {
    await _db
        .from('barang')
        .update({'nama': nama, 'stok': stok, 'status': status})
        .eq('id', id);
  }

  // 🗑️ Hapus barang
  Future<void> hapusBarang(String id) async {
    await _db.from('barang').delete().eq('id', id);
  }
}

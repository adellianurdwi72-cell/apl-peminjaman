import 'package:supabase_flutter/supabase_flutter.dart';

class BarangService {
  final SupabaseClient supabase = Supabase.instance.client;

  /// GET DATA BARANG
  Future<List<Map<String, dynamic>>> getBarang() async {
    final response = await supabase
        .from('barang')
        .select()
        .order('nama', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }

  /// TAMBAH BARANG
  Future<void> tambahBarang({
    required String nama,
    required int stok,
    required String kondisi,
    required String status,
  }) async {
    await supabase.from('barang').insert({
      'nama': nama,
      'stok': stok,
      'kondisi': kondisi,
      'status': status,
    });
  }

  /// UPDATE BARANG  ✅ (INI YANG SERING ERROR)
  Future<void> updateBarang({
    required String id,
    required String nama,
    required int stok,
    required String kondisi,
    required String status,
  }) async {
    await supabase
        .from('barang')
        .update({
          'nama': nama,
          'stok': stok,
          'kondisi': kondisi,
          'status': status,
        })
        .eq('id', id);
  }

  /// HAPUS BARANG  ✅ (INI JUGA)
  Future<void> hapusBarang(String id) async {
    await supabase.from('barang').delete().eq('id', id);
  }
}

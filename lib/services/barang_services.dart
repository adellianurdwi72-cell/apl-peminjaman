import '../config/supabase_client.dart';

class BarangService {
  Future<List> getBarang() async {
    final res = await supabase
        .from('barang')
        .select()
        .order('nama_barang');

    return res;
  }
}

  // CREATE: tambah barang baru
  Future<void> tambahBarang({
    required String nama,
    required int stok,
    required String kondisi,
    required String status,
  }) async {
    await supabase.from('barang').insert({
      'barang_id': DateTime.now().millisecondsSinceEpoch.toString(),
      'nama_barang': nama,
      'stok': stok,
      'kondisi': kondisi,
      'status_barang': status,
    });
  }

  // UPDATE: ubah data barang
  Future<void> updateBarang({
    required String id,
    required String nama,
    required int stok,
    required String kondisi,
    required String status,
  }) async {
    await supabase.from('barang').update({
      'nama_barang': nama,
      'stok': stok,
      'kondisi': kondisi,
      'status_barang': status,
    }).eq('barang_id', id);
  }

  // DELETE: hapus barang
  Future<void> hapusBarang(String id) async {
    await supabase.from('barang').delete().eq('barang_id', id);
  }

import 'package:supabase_flutter/supabase_flutter.dart';

class PeminjamanService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getPeminjaman() async {
    return await supabase.from('peminjaman').select().order('created_at');
  }

  Future<void> tambahPeminjaman(Map<String, dynamic> data) async {
    await supabase.from('peminjaman').insert(data);
  }

  Future<void> updateStatus(String id, String status) async {
    await supabase.from('peminjaman').update({'status': status}).eq('id', id);
  }

  Future<void> hapusPeminjaman(String id) async {
    await supabase.from('peminjaman').delete().eq('id', id);
  }
}

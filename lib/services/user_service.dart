import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

final supabase = Supabase.instance.client;

class UserService {
  static Future<List<UserModel>> getUsers() async {
    final res = await supabase.from('users').select().order('nama');
    return (res as List).map((e) => UserModel.fromMap(e)).toList();
  }

  static Future<void> addUser(String nama, String email, String role) async {
    await supabase.from('users').insert({
      'nama': nama,
      'email': email,
      'role': role,
    });
  }

  static Future<void> updateUser(String id, String nama, String email) async {
    await supabase
        .from('users')
        .update({'nama': nama, 'email': email})
        .eq('id', id);
  }

  static Future<void> deleteUser(String id) async {
    await supabase.from('users').delete().eq('id', id);
  }
}

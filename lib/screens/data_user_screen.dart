import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'user_form_screen.dart';
import '../widgets/app_drawer.dart';

class DataUserScreen extends StatefulWidget {
  const DataUserScreen({super.key});

  @override
  State<DataUserScreen> createState() => _DataUserScreenState();
}

class _DataUserScreenState extends State<DataUserScreen> {
  List<UserModel> users = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final data = await UserService.getUsers();

    debugPrint('TOTAL USER: ${data.length}');
    for (var u in data) {
      debugPrint('${u.nama} | ${u.email} | ${u.role}');
    }

    setState(() {
      users = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('DATA USER SCREEN TERBUKA');
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Data User"),
        backgroundColor: const Color(0xFFF4F1E8),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          section("Admin", users.where((u) => u.role == 'admin').toList()),
          section("Petugas", users.where((u) => u.role == 'petugas').toList()),
          section("Anggota", users.where((u) => u.role == 'anggota').toList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserFormScreen()),
          ).then((value) {
            if (value == true) fetchUsers();
          });
        },
      ),
    );
  }

  /// ===============================
  /// SECTION (ADMIN / PETUGAS / ANGGOTA)
  /// ===============================
  Widget section(String title, List<UserModel> list) {
    if (list.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...list.map(userCard).toList(),
        const SizedBox(height: 20),
      ],
    );
  }

  /// ===============================
  /// CARD USER
  /// ===============================
  Widget userCard(UserModel user) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(user.nama),
        subtitle: Text(user.email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// ✏️ EDIT
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.green),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UserFormScreen(user: user)),
                ).then((value) {
                  if (value == true) fetchUsers();
                });
              },
            ),

            /// 🗑 DELETE
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await Supabase.instance.client
                    .from('users')
                    .delete()
                    .eq('id', user.id);

                fetchUsers();
              },
            ),
          ],
        ),
      ),
    );
  }
}

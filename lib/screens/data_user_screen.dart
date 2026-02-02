import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'user_form_screen.dart';

class DataUserScreen extends StatefulWidget {
  const DataUserScreen({super.key});

  @override
  State<DataUserScreen> createState() => _DataUserScreenState();
}

class _DataUserScreenState extends State<DataUserScreen> {
  final List<UserModel> users = [
    UserModel(name: "Raib", email: "admin@gmail.com", role: "Admin"),
    UserModel(name: "Seli", email: "petugas@gmail.com", role: "Petugas"),
    UserModel(name: "Eko", email: "eko@gmail.com", role: "Anggota"),
    UserModel(name: "Citra", email: "citra@gmail.com", role: "Anggota"),
  ];

  void _addUser(UserModel user) {
    setState(() => users.add(user));
  }

  void _updateUser(int index, UserModel user) {
    setState(() => users[index] = user);
  }

  void _deleteUser(int index) {
    setState(() => users.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EEDC),
      appBar: AppBar(
        title: const Text("Data User"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB7D2A3),
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push<UserModel>(
            context,
            MaterialPageRoute(builder: (_) => const UserFormScreen()),
          );
          if (result != null) _addUser(result);
        },
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(user.name),
              subtitle: Text("${user.email}\n${user.role}"),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.green),
                    onPressed: () async {
                      final result = await Navigator.push<UserModel>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserFormScreen(user: user),
                        ),
                      );
                      if (result != null) _updateUser(index, result);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteUser(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

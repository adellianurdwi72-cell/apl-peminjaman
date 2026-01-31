import 'package:flutter/material.dart';
import 'data_user_screen.dart';

class UserFormScreen extends StatefulWidget {
  final User? user;
  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  String role = "Anggota";

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.user?.name ?? "");
    emailController =
        TextEditingController(text: widget.user?.email ?? "");
    role = widget.user?.role ?? "Anggota";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? "Tambah User" : "Edit User"),
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
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nama"),
                validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
              ),
              DropdownButtonFormField<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: "Admin", child: Text("Admin")),
                  DropdownMenuItem(value: "Petugas", child: Text("Petugas")),
                  DropdownMenuItem(value: "Anggota", child: Text("Anggota")),
                ],
                onChanged: (v) => setState(() => role = v!),
                decoration: const InputDecoration(labelText: "Role"),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7D2A3),
                  minimumSize: const Size(double.infinity, 45),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      User(
                        name: nameController.text,
                        email: emailController.text,
                        role: role,
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

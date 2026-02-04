import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class UserFormScreen extends StatefulWidget {
  final UserModel? user; // null = tambah, ada = edit

  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();

  String _role = 'anggota';
  bool _loading = false;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();

    /// MODE EDIT
    if (widget.user != null) {
      _namaController.text = widget.user!.nama;
      _emailController.text = widget.user!.email;
      _role = widget.user!.role;
    }
  }

  Future<void> _simpanUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      if (widget.user == null) {
        /// ➕ TAMBAH USER
        await supabase.from('users').insert({
          'nama': _namaController.text,
          'email': _emailController.text,
          'role': _role,
        });
      } else {
        /// ✏️ EDIT USER
        await supabase
            .from('users')
            .update({
              'nama': _namaController.text,
              'email': _emailController.text,
              'role': _role,
            })
            .eq('id', widget.user!.id);
      }

      if (mounted) {
        Navigator.pop(context, true); // trigger refresh
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan user: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.user != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit User' : 'Tambah User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              /// NAMA
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              /// EMAIL
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Email wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              /// ROLE
              DropdownButtonFormField<String>(
                value: _role,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'petugas', child: Text('Petugas')),
                  DropdownMenuItem(value: 'anggota', child: Text('Anggota')),
                ],
                onChanged: (v) => setState(() => _role = v!),
              ),
              const SizedBox(height: 24),

              /// SIMPAN
              ElevatedButton(
                onPressed: _loading ? null : _simpanUser,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

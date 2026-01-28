import 'package:flutter/material.dart';
import '../theme/app_color.dart';

class DataBarangScreen extends StatelessWidget {
  const DataBarangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final barang = [
      'Oven',
      'Loyang',
      'Timbangan Digital',
      'Blender',
      'Kompor Portable',
      'Mixer',
      'Rolling Pin',
      'Spatula',
      'Whisk',
      'Cetakan Kue',
      'Wajan',
      'Pisau',
      'Talenan',
      'Spuit',
      'Blow Torch',
      'Mandoline Slicer',
      'Sendok Takar',
      'Gelas Ukur',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Barang'),
        backgroundColor: AppColor.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/tambah-barang');
            },
          )
        ],
      ),
      body: Column(
        children: [
          // SEARCH
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Barang...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // LIST BARANG
          Expanded(
            child: ListView.builder(
              itemCount: barang.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.kitchen),
                    title: Text(barang[index]),
                    subtitle: const Text('Status: Tersedia'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

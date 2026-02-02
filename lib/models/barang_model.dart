class Barang {
  final String id;
  final String nama;
  final int stok;
  final String kondisi;
  final String status;

  Barang({
    required this.id,
    required this.nama,
    required this.stok,
    required this.kondisi,
    required this.status,
  });

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      id: map['id'].toString(), // 🔥 penting
      nama: map['nama'],
      stok: map['stok'],
      kondisi: map['kondisi'],
      status: map['status'],
    );
  }
}

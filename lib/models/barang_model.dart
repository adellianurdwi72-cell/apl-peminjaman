class Barang {
  final String id;
  final String nama;
  final String kategoriId;
  final int stok;
  final String status;

  Barang({
    required this.id,
    required this.nama,
    required this.kategoriId,
    required this.stok,
    required this.status,
  });

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      id: map['id'],
      nama: map['nama'],
      kategoriId: map['kategori_id'],
      stok: map['stok'],
      status: map['status'],
    );
  }
}

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
      id: map['barang_id'],
      nama: map['nama_barang'],
      stok: map['stok'],
      kondisi: map['kondisi'],
      status: map['status_barang'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'barang_id': id,
      'nama_barang': nama,
      'stok': stok,
      'kondisi': kondisi,
      'status_barang': status,
    };
  }
}

class Peminjaman {
  final String id;
  final String nama;
  final String barang;
  final String tanggal;
  final String status;

  Peminjaman({
    required this.id,
    required this.nama,
    required this.barang,
    required this.tanggal,
    required this.status,
  });

  factory Peminjaman.fromMap(Map<String, dynamic> map) {
    return Peminjaman(
      id: map['id'],
      nama: map['nama'],
      barang: map['barang'],
      tanggal: map['tanggal'],
      status: map['status'],
    );
  }
}

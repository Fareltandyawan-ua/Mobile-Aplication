class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final String email;
  final String jurusan;
  final String semester;
  final String status;
  final String tahunMasuk;
  final String ipk;

  MahasiswaAktifModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.jurusan,
    required this.semester,
    this.status = 'Aktif',
    required this.tahunMasuk,
    required this.ipk,
  });

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaAktifModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      jurusan: json['jurusan'] ?? '',
      semester: json['semester'] ?? '',
      status: json['status'] ?? 'Aktif',
      tahunMasuk: json['tahunMasuk'] ?? '',
      ipk: json['ipk'] ?? '0.00',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'email': email,
      'jurusan': jurusan,
      'semester': semester,
      'status': status,
      'tahunMasuk': tahunMasuk,
      'ipk': ipk,
    };
  }
}

class ProfileModel {
  final String nama;
  final String jabatan;
  final String email;
  final String telepon;
  final String institusi;
  final String nip;
  final String alamat;
  final String bidangKeahlian;

  ProfileModel({
    required this.nama,
    required this.jabatan,
    required this.email,
    required this.telepon,
    required this.institusi,
    required this.nip,
    required this.alamat,
    required this.bidangKeahlian,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nama: json['nama'] ?? '',
      jabatan: json['jabatan'] ?? '',
      email: json['email'] ?? '',
      telepon: json['telepon'] ?? '',
      institusi: json['institusi'] ?? '',
      nip: json['nip'] ?? '',
      alamat: json['alamat'] ?? '',
      bidangKeahlian: json['bidangKeahlian'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'jabatan': jabatan,
      'email': email,
      'telepon': telepon,
      'institusi': institusi,
      'nip': nip,
      'alamat': alamat,
      'bidangKeahlian': bidangKeahlian,
    };
  }

  ProfileModel copyWith({
    String? nama,
    String? jabatan,
    String? email,
    String? telepon,
    String? institusi,
    String? nip,
    String? alamat,
    String? bidangKeahlian,
  }) {
    return ProfileModel(
      nama: nama ?? this.nama,
      jabatan: jabatan ?? this.jabatan,
      email: email ?? this.email,
      telepon: telepon ?? this.telepon,
      institusi: institusi ?? this.institusi,
      nip: nip ?? this.nip,
      alamat: alamat ?? this.alamat,
      bidangKeahlian: bidangKeahlian ?? this.bidangKeahlian,
    );
  }
}

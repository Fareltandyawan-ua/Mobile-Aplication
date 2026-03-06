import 'dart:io';

// ============================================================
// A. CLASS - Contoh dasar class Mahasiswa
// ============================================================
class Mahasiswa {
  String nama = "Anang";

  void tampilkanData() {
    print(nama);
  }
}

// ============================================================
// B. OBJECT - Class Mahasiswa dengan properti nullable
// ============================================================
class MahasiswaObj {
  String? nama;
  int? nim;
  String? jurusan;

  void tampilkanData() {
    print("Nama: ${nama ?? 'Belum diisi'}");
    print("NIM: ${nim ?? 'Belum diisi'}");
    print("Jurusan: ${jurusan ?? 'Belum diisi'}");
  }
}

// ============================================================
// C. EXTENDS - Pewarisan dari class Mahasiswa
// ============================================================
class MahasiswaBase {
  String nama;
  int nim;
  String jurusan;

  MahasiswaBase({required this.nama, required this.nim, required this.jurusan});

  void tampilkanData() {
    print("Nama: $nama");
    print("NIM: $nim");
    print("Jurusan: $jurusan");
  }
}

// MahasiswaAktif mewarisi MahasiswaBase
class MahasiswaAktif extends MahasiswaBase {
  String statusAktif;
  int semesterAktif;

  MahasiswaAktif({
    required String nama,
    required int nim,
    required String jurusan,
    required this.statusAktif,
    required this.semesterAktif,
  }) : super(nama: nama, nim: nim, jurusan: jurusan);

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("Status: $statusAktif");
    print("Semester: $semesterAktif");
  }
}

// MahasiswaAlumni mewarisi MahasiswaBase
class MahasiswaAlumni extends MahasiswaBase {
  int tahunLulus;
  String tempatKerja;

  MahasiswaAlumni({
    required String nama,
    required int nim,
    required String jurusan,
    required this.tahunLulus,
    required this.tempatKerja,
  }) : super(nama: nama, nim: nim, jurusan: jurusan);

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("Tahun Lulus: $tahunLulus");
    print("Tempat Kerja: $tempatKerja");
  }
}

// ============================================================
// D. MIXIN - Class dasar Mahasiswa extends ke Dosen & Fakultas
// ============================================================

// Mixin 1: Kemampuan mengajar
mixin BisaMengajar {
  List<String> mataKuliahDiajar = [];

  void tambahMataKuliah(String mk) {
    mataKuliahDiajar.add(mk);
    print("Mata kuliah '$mk' ditambahkan.");
  }

  void tampilkanMataKuliah() {
    print("Mata Kuliah yang Diajar:");
    for (var mk in mataKuliahDiajar) {
      print("  - $mk");
    }
  }
}

// Mixin 2: Kemampuan penelitian
mixin BisaMeneliti {
  List<String> penelitian = [];

  void tambahPenelitian(String judul) {
    penelitian.add(judul);
    print("Penelitian '$judul' ditambahkan.");
  }

  void tampilkanPenelitian() {
    print("Daftar Penelitian:");
    for (var p in penelitian) {
      print("  - $p");
    }
  }
}

// Mixin 3: Kemampuan administrasi fakultas
mixin AdministrasiFakultas {
  void buatLaporan(String jenis) {
    print("Laporan '$jenis' berhasil dibuat.");
  }

  void validasiDokumen(String dokumen) {
    print("Dokumen '$dokumen' telah divalidasi.");
  }
}

// Class Dosen extends MahasiswaBase + menggunakan mixin
class Dosen extends MahasiswaBase with BisaMengajar, BisaMeneliti {
  String nip;
  String jabatan;

  Dosen({
    required String nama,
    required int nim,
    required String jurusan,
    required this.nip,
    required this.jabatan,
  }) : super(nama: nama, nim: nim, jurusan: jurusan);

  @override
  void tampilkanData() {
    print("=== DATA DOSEN ===");
    super.tampilkanData();
    print("NIP: $nip");
    print("Jabatan: $jabatan");
    tampilkanMataKuliah();
    tampilkanPenelitian();
  }
}

// Class Fakultas menggunakan mixin administrasi
class Fakultas extends MahasiswaBase with AdministrasiFakultas, BisaMeneliti {
  String namaFakultas;
  String posisi;

  Fakultas({
    required String nama,
    required int nim,
    required String jurusan,
    required this.namaFakultas,
    required this.posisi,
  }) : super(nama: nama, nim: nim, jurusan: jurusan);

  @override
  void tampilkanData() {
    print("=== DATA FAKULTAS ===");
    super.tampilkanData();
    print("Fakultas: $namaFakultas");
    print("Posisi: $posisi");
  }
}

// ============================================================
// MAIN - Menjalankan semua contoh
// ============================================================
void main() {
  // --- A. Class ---
  print("===== A. CLASS =====");
  var mahasiswa1 = Mahasiswa();
  mahasiswa1.tampilkanData();

  stdout.write("Masukkan nama baru: ");
  String? namaBaru = stdin.readLineSync();
  if (namaBaru != null && namaBaru.isNotEmpty) {
    mahasiswa1.nama = namaBaru;
    print("Nama berhasil diubah.");
    mahasiswa1.tampilkanData();
  } else {
    print("Nama tidak boleh kosong.");
  }

  // --- B. Object ---
  print("\n===== B. OBJECT =====");
  MahasiswaObj mahasiswa = MahasiswaObj();
  print("Masukkan Nama Mahasiswa:");
  mahasiswa.nama = stdin.readLineSync();
  print("Masukkan NIM Mahasiswa:");
  mahasiswa.nim = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  print("Masukkan Jurusan Mahasiswa:");
  mahasiswa.jurusan = stdin.readLineSync();
  mahasiswa.tampilkanData();

  // --- C. Extends ---
  print("\n===== C. EXTENDS =====");
  var aktif = MahasiswaAktif(
    nama: "Budi",
    nim: 202301,
    jurusan: "Teknik Informatika",
    statusAktif: "Aktif",
    semesterAktif: 5,
  );
  print("-- Mahasiswa Aktif --");
  aktif.tampilkanData();

  var alumni = MahasiswaAlumni(
    nama: "Sari",
    nim: 201901,
    jurusan: "Sistem Informasi",
    tahunLulus: 2023,
    tempatKerja: "PT. Teknologi Nusantara",
  );
  print("-- Mahasiswa Alumni --");
  alumni.tampilkanData();

  // --- D. Mixin ---
  print("\n===== D. MIXIN =====");
  var dosen = Dosen(
    nama: "Dr. Ahmad",
    nim: 198501,
    jurusan: "Teknik Informatika",
    nip: "19850101200501001",
    jabatan: "Lektor Kepala",
  );
  dosen.tambahMataKuliah("Pemrograman Mobile");
  dosen.tambahMataKuliah("Basis Data");
  dosen.tambahPenelitian("Implementasi AI dalam Pendidikan");
  dosen.tampilkanData();

  var dekan = Fakultas(
    nama: "Prof. Hendra",
    nim: 197001,
    jurusan: "Teknik Informatika",
    namaFakultas: "Fakultas Teknik",
    posisi: "Dekan",
  );
  dekan.buatLaporan("Laporan Semester Genap 2024");
  dekan.validasiDokumen("SK Mahasiswa Baru");
  dekan.tampilkanData();
}

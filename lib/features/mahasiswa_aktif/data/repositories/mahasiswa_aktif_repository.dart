import 'package:d4tivokasi/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  /// Mendapatkan daftar mahasiswa aktif
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy mahasiswa aktif
    return [
      MahasiswaAktifModel(
        nama: 'Agus Pratama',
        nim: '2022001',
        email: 'agus.pratama@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '4',
        status: 'Aktif',
        tahunMasuk: '2022',
        ipk: '3.75',
      ),
      MahasiswaAktifModel(
        nama: 'Bella Safira',
        nim: '2022002',
        email: 'bella.safira@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '4',
        status: 'Aktif',
        tahunMasuk: '2022',
        ipk: '3.90',
      ),
      MahasiswaAktifModel(
        nama: 'Candra Wijaya',
        nim: '2023001',
        email: 'candra.wijaya@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '2',
        status: 'Aktif',
        tahunMasuk: '2023',
        ipk: '3.60',
      ),
      MahasiswaAktifModel(
        nama: 'Diana Putri',
        nim: '2023002',
        email: 'diana.putri@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '2',
        status: 'Aktif',
        tahunMasuk: '2023',
        ipk: '3.85',
      ),
      MahasiswaAktifModel(
        nama: 'Eko Wahyudi',
        nim: '2021003',
        email: 'eko.wahyudi@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '6',
        status: 'Aktif',
        tahunMasuk: '2021',
        ipk: '3.50',
      ),
      MahasiswaAktifModel(
        nama: 'Fitri Anggraini',
        nim: '2021004',
        email: 'fitri.anggraini@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '6',
        status: 'Aktif',
        tahunMasuk: '2021',
        ipk: '3.95',
      ),
    ];
  }

  /// Refresh data mahasiswa aktif
  Future<List<MahasiswaAktifModel>> refreshMahasiswaAktif() async {
    return getMahasiswaAktifList();
  }
}

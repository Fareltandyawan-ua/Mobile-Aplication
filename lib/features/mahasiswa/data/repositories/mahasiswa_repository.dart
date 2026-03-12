import 'package:d4tivokasi/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  /// Mendapatkan daftar mahasiswa
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy mahasiswa
    return [
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '2021001',
        email: 'budi.santoso@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '6',
      ),
      MahasiswaModel(
        nama: 'Siti Rahayu',
        nim: '2021002',
        email: 'siti.rahayu@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '6',
      ),
      MahasiswaModel(
        nama: 'Ahmad Fauzi',
        nim: '2022001',
        email: 'ahmad.fauzi@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '4',
      ),
      MahasiswaModel(
        nama: 'Dewi Lestari',
        nim: '2022002',
        email: 'dewi.lestari@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '4',
      ),
      MahasiswaModel(
        nama: 'Rizky Pratama',
        nim: '2023001',
        email: 'rizky.pratama@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '2',
      ),
      MahasiswaModel(
        nama: 'Nurul Hidayah',
        nim: '2023002',
        email: 'nurul.hidayah@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '2',
      ),
      MahasiswaModel(
        nama: 'Fajar Setiawan',
        nim: '2020001',
        email: 'fajar.setiawan@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '8',
      ),
      MahasiswaModel(
        nama: 'Indah Permata',
        nim: '2020002',
        email: 'indah.permata@student.ac.id',
        jurusan: 'Teknik Informatika',
        semester: '8',
      ),
    ];
  }

  /// Refresh data mahasiswa
  Future<List<MahasiswaModel>> refreshMahasiswa() async {
    return getMahasiswaList();
  }
}

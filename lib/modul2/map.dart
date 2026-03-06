import 'dart:io';

void main() {
  Map<String, String> data = {
    'Anang': '081234567890',
    'Arman': '082345678901',
    'Doni': '083456789012',
  };
  print('data awal: $data');

  // c. Tambah data
  data['Rio'] = '084567890123';
  print('data setelah ditambahkan: $data');

  // d. Tampilkan data berdasarkan key
  print('Nomor Anang: ${data['Anang']}');

  // e. Ubah data
  data['Arman'] = '099999999999';
  print('data setelah diubah : $data');

  // Hapus data
  data.remove('Doni');
  print('data setelah dihapus : $data');

  // Cek data berdasarkan key
  print('Apakah "Anang" ada? ${data.containsKey("Anang")}');
  print('Apakah "Doni" ada? ${data.containsKey("Doni")}');

  // Hitung jumlah data
  print('Jumlah data: ${data.length}');

  // Tampilkan semua key
  print('Semua key: ${data.keys.toList()}');

  // Tampilkan semua value
  print('Semua value: ${data.values.toList()}');

  // BAGIAN 2: Input SINGLE Mahasiswa

  print('\n=== INPUT DATA MAHASISWA ===');
  Map<String, dynamic> mahasiswa = {};

  stdout.write('Masukkan NIM: ');
  mahasiswa['nim'] = stdin.readLineSync()!;

  stdout.write('Masukkan Nama: ');
  mahasiswa['nama'] = stdin.readLineSync()!;

  stdout.write('Masukkan Jurusan: ');
  mahasiswa['jurusan'] = stdin.readLineSync()!;

  stdout.write('Masukkan IPK: ');
  mahasiswa['ipk'] = stdin.readLineSync()!;

  print('Data Mahasiswa: $mahasiswa');

  // BAGIAN 3: Input MULTIPLE Mahasiswa

  print('\n=== INPUT MULTIPLE MAHASISWA ===');
  List<Map<String, dynamic>> listMahasiswa = [];

  int jumlah = 0;
  while (jumlah <= 0) {
    stdout.write('Masukkan jumlah mahasiswa: ');
    try {
      jumlah = int.parse(stdin.readLineSync()!);
      if (jumlah <= 0) print('Masukkan angka lebih dari 0!');
    } catch (e) {
      print('Input tidak valid!');
    }
  }

  for (int i = 0; i < jumlah; i++) {
    print('\n---- Mahasiswa ke-${i + 1} ----');
    Map<String, dynamic> mhs = {};

    stdout.write('Masukkan NIM: ');
    mhs['nim'] = stdin.readLineSync()!;

    stdout.write('Masukkan Nama: ');
    mhs['nama'] = stdin.readLineSync()!;

    stdout.write('Masukkan Jurusan: ');
    mhs['jurusan'] = stdin.readLineSync()!;

    stdout.write('Masukkan IPK: ');
    mhs['ipk'] = stdin.readLineSync()!;

    listMahasiswa.add(mhs);
  }

  // Tampilkan semua mahasiswa
  print('\n=== SEMUA DATA MAHASISWA ===');
  for (int i = 0; i < listMahasiswa.length; i++) {
    print('Mahasiswa ke-${i + 1}: ${listMahasiswa[i]}');
  }
}

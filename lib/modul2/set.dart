import 'dart:io';

void main() {
  // Membuat set dengan data awal
  Set<String> burung = {'Merpati', 'Elang', 'Kakatua'};
  print('Burung: $burung');

  // Tambah data
  burung.add('Perkutut');
  print('Burung setelah ditambahkan: $burung');

  //Tambah data duplicate
  burung.add('Merpati');
  print('Burung setelah diduplikat: $burung');

  // Hapus data
  burung.remove('Kakatua');
  print('Burung setelah di hapus: $burung');

  // Cek data tertentu apakah ada
  print('Apakah "Merpati" ada? ${burung.contains('Merpati')}');
  print('Apakah "Kakatua" ada? ${burung.contains('Kakatua')}');

  // Hitung jumlah data
  print('Jumlah data: ${burung.length}');

  // Set dengan input data
  Set<String> dataSet = {};
  print('\nData set kosong: $dataSet');

  int count = 0;
  while (count <= 0) {
    stdout.write('Masukkan jumlah data set: ');
    String? input = stdin.readLineSync();
    try {
      count = int.parse(input!);
      if (count <= 0) {
        print('Masukkan angka lebih dari 0!');
      }
    } catch (e) {
      print('Input tidak valid!');
    }
  }

  for (int i = 0; i < count; i++) {
    stdout.write('Data ke-${i + 1}:');
    String x = stdin.readLineSync()!;
    dataSet.add(x);
  }

  // Tampilkan semua data
  print('n\=== SEMUA DATA ===');
  int nomor = 1;
  for (String item in dataSet) {
    print('$nomor. $item');
    nomor++;
  }
  print('Total data: ${dataSet.length}');

  // Tambah data baru
  stdout.write('Masukkan data baru: ');
  String dataBaru = stdin.readLineSync()!;
  if (dataSet.add(dataBaru)) {
    print('Data "$dataBaru" berhasil ditambahkan!');
  } else {
    print('Data "$dataBaru" sudah ada(duplikat), tidak ditambahkan!');
  }

  // Hapus data
  stdout.write('Masukkan data yang ingin dihapus: ');
  String dataHapus = stdin.readLineSync()!;
  if (dataSet.remove('dataHapus')) {
    print('Data "$dataHapus" berhasil dihapus!');
  } else {
    print('Data "$dataHapus" tidak ditemukan!');
  }

  // Cek data
  stdout.write('Masukkan data yang ingin dicek: ');
  String dataCek = stdin.readLineSync()!;
  if (dataSet.contains(dataCek)) {
    print('Data "$dataCek" ada di Set!');
  } else {
    print('Data "$dataCek" tidak ada di Set!');
  }

  // Tampilkan hasil akhir
  print('\n=== HASIL AKHIR SET ===');
  nomor = 1;
  for (String item in dataSet) {
    print('$nomor. $item');
    nomor++;
  }
  print('Total data akhir: ${dataSet.length}');
}

import 'dart:io';

void main() {
  List<String> names = ['Alfa', 'Beta', 'Charlie'];
  print('Names: $names');

  // Menambahkan data dalam list
  names.add('Delta');
  print('Names setelah ditambahkan: $names');

  // Mengambil data index tertentu
  print('Elemen pertama: ${names[0]}');
  print('Elemen kedua: ${names[1]}');

  // Mengubah data pada index tertentu
  names[1] = 'Bravo';
  print('Names setelah diubah: $names');

  // Menghapus data dari list
  names.remove('Charlie');
  print('Names setelah dihapus: $names');

  // Menghitung jumlah data dalam list
  print('Jumlah data: ${names.length}');

  // Loping data list
  print('Menampilkan setiap elemen:');
  for (String name in names) {
    print(name);
  }

  // Membuat list kosong
  List<String> dataList = [];
  print('Data list kosong: $dataList');

  // Mengambil jumlah data dari pengguna
  int count = 0;
  while (count <= 0) {
    stdout.write('Masukkan jumlah list: ');
    String? input = stdin.readLineSync();
    try {
      count = int.parse(input!);
      if (count <= 0) {
        print('Masukkan angka lebih dari 0!');
      }
    } catch (e) {
      print('Input tidak valid! Masukkan angka yang benar.');
    }
  }

  // Masukkan data ke dalam list menggunakan for loop
  for (int i = 0; i < count; i++) {
    stdout.write('data ke-${i + 1}:');
    String x = stdin.readLineSync()!;
    dataList.add(x);
  }

  // Menampilkan data list
  print('Data list:');
  print(dataList);

  // Tampil berdasarkan index tertentu
  stdout.write('\nMasukkan index yang ingin ditampilkan: ');
  int indexTampil = int.parse(stdin.readLineSync()!);

  if (indexTampil >= 0 && indexTampil < dataList.length) {
    print('Data pada index $indexTampil: ${dataList[indexTampil]}');
  } else {
    print('Index tidak valid!');
  }

  // Ubah berdasarkan index
  stdout.write('\nMasukkan index yang ingin diubah: ');
  int indexUbah = int.parse(stdin.readLineSync()!);

  if (indexUbah >= 0 && indexUbah < dataList.length) {
    stdout.write('Masukkan data baru: ');
    String dataBaru = stdin.readLineSync()!;
    dataList[indexUbah] = dataBaru;
    print('Data berhasil diubah.');
  } else {
    print('Index tidak valid!');
  }

  // Hapus berdasarkan index
  stdout.write('\nMasukkan index yang ingin dihapus: ');
  int indexHapus = int.parse(stdin.readLineSync()!);

  if (indexHapus >= 0 && indexHapus < dataList.length) {
    dataList.removeAt(indexHapus);
    print('Data berhasil dihapus.');
  } else {
    print('Index tidak valid!');
  }

  // Hasil Akhir
  print('\n=== SEMUA DATA ===');
  for (int i = 0; i < dataList.length; i++) {
    print('Index $i: ${dataList[i]}');
  }
}

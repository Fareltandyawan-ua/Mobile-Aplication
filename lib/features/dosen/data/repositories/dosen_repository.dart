import 'dart:convert';
import 'package:d4tivokasi/features/dosen/data/models/dosen_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class DosenRepository {
  /// Mendapatkan daftar dosen menggunakan http
  Future<List<DosenModel>> getDosenList() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data); // Debug: Tampilkan data yang sudah di-decode
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Gagal memuat data dosen: ${response.statusCode}');
    }
  }
}

class DosenRepositoryDio {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  /// Mendapatkan daftar dosen menggunakan Dio
  Future<List<DosenModel>> getDosenList() async {
    try {
      final response = await _dio.get('/users');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print(data); // Debug
        return data.map((json) => DosenModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data dosen: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioError: ${e.message}');
      throw Exception('Gagal memuat data dosen: ${e.message}');
    }
  }
}

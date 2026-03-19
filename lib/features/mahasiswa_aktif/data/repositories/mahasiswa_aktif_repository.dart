import 'dart:convert';
import 'package:d4tivokasi/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

// ============================================================
// MahasiswaAktifRepository menggunakan HTTP
// API: https://jsonplaceholder.typicode.com/posts
// ============================================================
class MahasiswaAktifRepository {
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data); // Debug
      return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception(
        'Gagal memuat data mahasiswa aktif: ${response.statusCode}',
      );
    }
  }
}

// ============================================================
// MahasiswaAktifRepositoryDio menggunakan Dio
// API: https://jsonplaceholder.typicode.com/posts
// ============================================================
class MahasiswaAktifRepositoryDio {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    try {
      final response = await _dio.get('/posts');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print(data); // Debug
        return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioError: ${e.message}');
      throw Exception('Gagal memuat data mahasiswa aktif: ${e.message}');
    }
  }
}

import 'dart:convert';
import 'package:d4tivokasi/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

// ============================================================
// MahasiswaRepository menggunakan HTTP
// API: https://jsonplaceholder.typicode.com/comments
// ============================================================
class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data); // Debug
      return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Gagal memuat data mahasiswa: ${response.statusCode}');
    }
  }
}

// ============================================================
// MahasiswaRepositoryDio menggunakan Dio
// API: https://jsonplaceholder.typicode.com/comments
// ============================================================
class MahasiswaRepositoryDio {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ),
  );

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dio.get('/comments');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print(data); // Debug
        return data.map((json) => MahasiswaModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioError: ${e.message}');
      throw Exception('Gagal memuat data mahasiswa: ${e.message}');
    }
  }
}

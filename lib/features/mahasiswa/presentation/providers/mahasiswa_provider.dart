import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:d4tivokasi/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:d4tivokasi/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

// Repository Provider
final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

// ————————————————————————————————————————————————————————
// Local Storage khusus Mahasiswa (key terpisah dari dosen)
// ————————————————————————————————————————————————————————
const String _savedMahasiswaKey = 'saved_mahasiswa';

Future<void> addMahasiswaToSavedList({
  required String mahasiswaId,
  required String name,
  required String email,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final rawList = prefs.getStringList(_savedMahasiswaKey) ?? [];

  final isDuplicate = rawList.any((item) {
    final map = jsonDecode(item) as Map<String, dynamic>;
    return map['mahasiswa_id'] == mahasiswaId;
  });

  if (isDuplicate) return;

  final newItem = jsonEncode({
    'mahasiswa_id': mahasiswaId,
    'name': name,
    'email': email,
    'saved_at': DateTime.now().toIso8601String(),
  });

  rawList.add(newItem);
  await prefs.setStringList(_savedMahasiswaKey, rawList);
}

Future<List<Map<String, String>>> getSavedMahasiswaList() async {
  final prefs = await SharedPreferences.getInstance();
  final rawList = prefs.getStringList(_savedMahasiswaKey) ?? [];
  return rawList.map((item) {
    final map = jsonDecode(item) as Map<String, dynamic>;
    return {
      'mahasiswa_id': (map['mahasiswa_id'] ?? '').toString(),
      'name': (map['name'] ?? '').toString(),
      'email': (map['email'] ?? '').toString(),
      'saved_at': (map['saved_at'] ?? '').toString(),
    };
  }).toList();
}

Future<void> removeSavedMahasiswa(String mahasiswaId) async {
  final prefs = await SharedPreferences.getInstance();
  final rawList = prefs.getStringList(_savedMahasiswaKey) ?? [];
  rawList.removeWhere((item) {
    final map = jsonDecode(item) as Map<String, dynamic>;
    return map['mahasiswa_id'] == mahasiswaId;
  });
  await prefs.setStringList(_savedMahasiswaKey, rawList);
}

Future<void> clearSavedMahasiswaList() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_savedMahasiswaKey);
}

// Provider untuk saved mahasiswa
final savedMahasiswaProvider = FutureProvider<List<Map<String, String>>>((
  ref,
) async {
  return getSavedMahasiswaList();
});

// StateNotifier
class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;

  MahasiswaNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaList();
  }

  Future<void> saveSelectedMahasiswa(MahasiswaModel mahasiswa) async {
    await addMahasiswaToSavedList(
      mahasiswaId: mahasiswa.id.toString(),
      name: mahasiswa.name,
      email: mahasiswa.email,
    );
  }

  Future<void> removeSaved(String mahasiswaId) async {
    await removeSavedMahasiswa(mahasiswaId);
  }

  Future<void> clearSaved() async {
    await clearSavedMahasiswaList();
  }
}

final mahasiswaNotifierProvider = StateNotifierProvider.autoDispose<
  MahasiswaNotifier,
  AsyncValue<List<MahasiswaModel>>
>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  return MahasiswaNotifier(repository);
});
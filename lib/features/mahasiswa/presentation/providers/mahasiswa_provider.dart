import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d4tivokasi/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:d4tivokasi/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

// Provider HTTP
final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

// Provider Dio
final mahasiswaRepositoryDioProvider = Provider<MahasiswaRepositoryDio>((ref) {
  return MahasiswaRepositoryDio();
});

// StateNotifier menggunakan Dio
class MahasiswaNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepositoryDio _repository;

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
}

final mahasiswaNotifierProvider =
    StateNotifierProvider.autoDispose<
      MahasiswaNotifier,
      AsyncValue<List<MahasiswaModel>>
    >((ref) {
      final repository = ref.watch(mahasiswaRepositoryDioProvider);
      return MahasiswaNotifier(repository);
    });

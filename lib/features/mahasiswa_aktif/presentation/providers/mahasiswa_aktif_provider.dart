import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d4tivokasi/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:d4tivokasi/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart';

// Provider HTTP
final mahasiswaAktifRepositoryProvider = Provider<MahasiswaAktifRepository>((
  ref,
) {
  return MahasiswaAktifRepository();
});

// Provider Dio
final mahasiswaAktifRepositoryDioProvider =
    Provider<MahasiswaAktifRepositoryDio>((ref) {
      return MahasiswaAktifRepositoryDio();
    });

// StateNotifier menggunakan Dio
class MahasiswaAktifNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepositoryDio _repository;

  MahasiswaAktifNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadList();
  }

  Future<void> loadList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaAktifList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async => loadList();
}

final mahasiswaAktifNotifierProvider =
    StateNotifierProvider.autoDispose<
      MahasiswaAktifNotifier,
      AsyncValue<List<MahasiswaAktifModel>>
    >((ref) {
      final repository = ref.watch(mahasiswaAktifRepositoryDioProvider);
      return MahasiswaAktifNotifier(repository);
    });

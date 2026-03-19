import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d4tivokasi/features/dosen/data/models/dosen_model.dart';
import 'package:d4tivokasi/features/dosen/data/repositories/dosen_repository.dart';

// ============================================================
// Provider menggunakan HTTP
// ============================================================
final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
  return DosenRepository();
});

// ============================================================
// Provider menggunakan DIO
// ============================================================
final dosenRepositoryDioProvider = Provider<DosenRepositoryDio>((ref) {
  return DosenRepositoryDio();
});

// ============================================================
// StateNotifier - mengelola state list dosen (pakai DIO)
// ============================================================
class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepositoryDio _repository;

  DosenNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDosenList();
  }

  /// Load data dosen dalam bentuk list
  Future<void> loadDosenList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getDosenList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Refresh data dosen
  Future<void> refresh() async {
    await loadDosenList();
  }
}

// Dosen Notifier Provider (menggunakan Dio)
final dosenNotifierProvider =
    StateNotifierProvider.autoDispose<
      DosenNotifier,
      AsyncValue<List<DosenModel>>
    >((ref) {
      final repository = ref.watch(dosenRepositoryDioProvider);
      return DosenNotifier(repository);
    });

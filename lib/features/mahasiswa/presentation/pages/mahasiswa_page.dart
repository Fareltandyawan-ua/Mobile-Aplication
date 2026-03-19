import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d4tivokasi/core/constants/constants.dart';
import 'package:d4tivokasi/core/widgets/widgets.dart';
import '../providers/mahasiswa_provider.dart';
import '../widgets/mahasiswa_widget.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaNotifierProvider),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: mahasiswaState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data mahasiswa: ${error.toString()}',
          onRetry: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
        ),
        data: (mahasiswaList) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mahasiswaNotifierProvider),
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              itemCount: mahasiswaList.length,
              itemBuilder: (context, index) {
                return MahasiswaCard(
                  mahasiswa: mahasiswaList[index],
                  gradientColors:
                      AppConstants.dashboardGradients[index %
                          AppConstants.dashboardGradients.length],
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Detail: ${mahasiswaList[index].name}'),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

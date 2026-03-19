import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d4tivokasi/core/constants/constants.dart';
import 'package:d4tivokasi/core/widgets/widgets.dart';
import '../providers/mahasiswa_aktif_provider.dart';
import '../../data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaAktifNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaAktifNotifierProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: ${error.toString()}',
          onRetry: () =>
              ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
        ),
        data: (list) {
          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(mahasiswaAktifNotifierProvider),
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _MahasiswaAktifCard(
                  item: list[index],
                  gradientColors:
                      AppConstants.dashboardGradients[index %
                          AppConstants.dashboardGradients.length],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// _MahasiswaAktifCard - card untuk mahasiswa aktif dari API /posts
// ============================================================
class _MahasiswaAktifCard extends StatelessWidget {
  final MahasiswaAktifModel item;
  final List<Color> gradientColors;

  const _MahasiswaAktifCard({required this.item, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: gradientColors[0].withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar dengan inisial
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${item.id}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge userID & post ID
                  Row(
                    children: [
                      _badge(
                        'User: ${item.userId}',
                        gradientColors[0].withOpacity(0.1),
                        gradientColors[0],
                      ),
                      const SizedBox(width: 6),
                      _badge(
                        'Post: ${item.id}',
                        Colors.grey[100]!,
                        Colors.grey[600]!,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Title (kapital setiap kata)
                  Text(
                    _capitalize(item.title),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Body / deskripsi
                  Text(
                    item.body,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Aktif',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: gradientColors[0],
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : word,
        )
        .join(' ');
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:d4tivokasi/core/widgets/widgets.dart';
import 'package:d4tivokasi/features/profile/presentation/providers/profile_provider.dart';
import 'package:d4tivokasi/features/profile/presentation/widgets/profile_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(profileNotifierProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: profileState.when(
        // State: Loading
        loading: () => const LoadingWidget(),

        // State: Error
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data profil: ${error.toString()}',
          onRetry: () {
            ref.read(profileNotifierProvider.notifier).refresh();
          },
        ),

        // State: Data tersedia
        data: (profile) => ProfileDetailWidget(profile: profile),
      ),
    );
  }
}

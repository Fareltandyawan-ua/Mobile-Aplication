import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch dashboard data dari provider
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final selectedIndex = ref.watch(selectedStatIndexProvider);

    return Scaffold(
      body: dashboardState.when(
        // State: Loading
        loading: () => const LoadingWidget(),

        // State: Error
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: ${error.toString()}',
          onRetry: () {
            // Refresh data ketika tombol retry ditekan
            ref.read(dashboardNotifierProvider.notifier).refresh();
          },
        ), // CustomErrorWidget
        // State: Data loaded
        data: (dashboardData) {
          return RefreshIndicator(
            onRefresh: () async {
              // Pull to refresh
              await ref.read(dashboardNotifierProvider.notifier).refresh();
            },
            child: CustomScrollView(
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: DashboardHeader(userName: dashboardData.userName),
                ), // SliverToBoxAdapter
                // Stats Section
                SliverPadding(
                  padding: const EdgeInsets.all(AppConstants.paddingMedium),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Statistik',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ), // Text
                        const SizedBox(height: AppConstants.paddingMedium),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: AppConstants.paddingMedium,
                                mainAxisSpacing: AppConstants.paddingMedium,
                                childAspectRatio: 1.3,
                              ), // SliverGridDelegateWithFixedCrossAxisCount
                          itemCount: dashboardData.stats.length,
                          itemBuilder: (context, index) {
                            return StatCard(
                              stats: dashboardData.stats[index],
                              isSelected: selectedIndex == index,
                              onTap: () {
                                // Update selected stat menggunakan provider
                                ref
                                        .read(
                                          selectedStatIndexProvider.notifier,
                                        )
                                        .state =
                                    index;
                              },
                            ); // StatCard
                          },
                        ), // GridView.builder
                      ],
                    ),
                  ), // SliverToBoxAdapter
                ), // SliverPadding
                // Bottom spacing
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: AppConstants.paddingLarge),
                ), // SliverPadding
              ],
            ), // CustomScrollView
          ); // RefreshIndicator
        },
      ),

      // Floating Action Button - Contoh interaksi dengan provider
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh data
          ref.read(dashboardNotifierProvider.notifier).refresh();

          // Show snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Memperbarui data...'),
              duration: Duration(seconds: 1),
            ), // SnackBar
          );
        },
        child: const Icon(Icons.refresh),
      ), // FloatingActionButton
    ); // Scaffold
  }
}

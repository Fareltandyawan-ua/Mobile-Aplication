import '../models/dashboard_model.dart';

class DashboardRepository {
  /// Mendapatkan data dashboard
  Future<DashboardData> getDashboardData() async {
    // network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy
    return DashboardData(
      userName: 'Admin D4TI',
      lastUpdate: DateTime.now(),
      stats: [
        DashboardStats(
          title: 'Mahasiswa',
          value: '1,234',
          subtitle: 'Data mahasiswa',
          // percentage: 8.5,
          // isIncrease: true,
        ), // DashboardStats
        DashboardStats(
          title: 'Mahasiswa Aktif',
          value: '1,180',
          subtitle: 'Sedang aktif kuliah',
          // percentage: 5.2,
          // isIncrease: true,
        ), // DashboardStats
        DashboardStats(
          title: 'Dosen',
          value: '48',
          subtitle: 'Data dosen',
          // percentage: 2.1,
          // isIncrease: false,
        ), // DashboardStats
        DashboardStats(
          title: 'Profil',
          value: 'Lihat',
          subtitle: 'Informasi profil',
          // percentage: 3.5,
          // isIncrease: true,
        ), // DashboardStats
      ],
    ); // DashboardData
  }

  /// Refresh dashboard data
  Future<DashboardData> refreshDashboard() async {
    return getDashboardData();
  }

  /// Get specific stat by title
  Future<DashboardStats?> getStatByTitle(String title) async {
    final data = await getDashboardData();
    try {
      return data.stats.firstWhere((stat) => stat.title == title);
    } catch (e) {
      return null;
    }
  }
}

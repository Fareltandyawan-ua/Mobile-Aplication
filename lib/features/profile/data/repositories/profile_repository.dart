import 'package:d4tivokasi/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  /// Mendapatkan data profil admin
  Future<ProfileModel> getProfile() async {
    // Simulasi network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return ProfileModel(
      nama: 'Admin D4TI',
      jabatan: 'Administrator Sistem',
      email: 'admin@d4ti.ac.id',
      telepon: '+62 821-0000-0001',
      institusi: 'D4 Teknik Informatika Vokasi',
      nip: '198501012010011001',
      alamat: 'Kampus Vokasi, Universitas Brawijaya, Malang',
      bidangKeahlian: 'Sistem Informasi & Manajemen Data',
    );
  }

  /// Refresh data profil
  Future<ProfileModel> refreshProfile() async {
    return getProfile();
  }
}

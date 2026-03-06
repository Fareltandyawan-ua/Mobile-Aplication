import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard D4 TI Vokasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Data untuk GridView
  final List<Map<String, dynamic>> menuItems = const [
    {'icon': Icons.person, 'label': 'Profil', 'color': Colors.blue},
    {'icon': Icons.school, 'label': 'Akademik', 'color': Colors.green},
    {'icon': Icons.assignment, 'label': 'Tugas', 'color': Colors.orange},
    {'icon': Icons.grade, 'label': 'Nilai', 'color': Colors.red},
    {'icon': Icons.calendar_today, 'label': 'Jadwal', 'color': Colors.purple},
    {'icon': Icons.notifications, 'label': 'Notifikasi', 'color': Colors.teal},
  ];

  // Data untuk ListView
  final List<Map<String, String>> beritaList = const [
    {
      'judul': 'Pengumuman Jadwal UAS',
      'isi': 'UAS akan dilaksanakan pada tanggal 10 Juni 2025',
    },
    {
      'judul': 'Pendaftaran KRS',
      'isi': 'Pendaftaran KRS semester baru dibuka 1 Juli 2025',
    },
    {
      'judul': 'Seminar Nasional IT',
      'isi': 'Seminar Nasional IT diselenggarakan 20 Mei 2025',
    },
    {
      'judul': 'Pengumuman Beasiswa',
      'isi': 'Pendaftaran beasiswa prestasi dibuka sampai 30 April 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ============================================================
      // AppBar
      // ============================================================
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'D4 TI Vokasi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      // ============================================================
      // Body: SingleChildScrollView agar bisa scroll
      // ============================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------------
            // A. CONTAINER: Header/Banner dengan Stack
            // ----------------------------------------------------------
            Stack(
              children: [
                // Container background
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.deepPurple, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                // Stack: teks di atas container
                Positioned(
                  top: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Selamat Datang 👋',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Mahasiswa TI Vokasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Semester Genap 2024/2025',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                // Stack: Icon di pojok kanan
                Positioned(
                  right: 20,
                  top: 25,
                  child: Icon(
                    Icons.school,
                    color: Colors.white.withOpacity(0.3),
                    size: 80,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ----------------------------------------------------------
            // B. ROW: Info Ringkas (SKS, IPK, Kehadiran)
            // ----------------------------------------------------------
            const Text(
              'Info Akademik',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoCard('SKS\nDiambil', '18', Colors.blue),
                _infoCard('IPK', '3.75', Colors.green),
                _infoCard('Kehadiran', '92%', Colors.orange),
              ],
            ),

            const SizedBox(height: 20),

            // ----------------------------------------------------------
            // C. CONTAINER dalam COLUMN: Menu Utama (GridView)
            // ----------------------------------------------------------
            const Text(
              'Menu Utama',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          color: item['color'] as Color,
                          size: 32,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['label'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // ----------------------------------------------------------
            // D. CONTAINER dalam COLUMN: Berita (ListView)
            // ----------------------------------------------------------
            const Text(
              'Berita & Pengumuman',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: beritaList.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, indent: 16, endIndent: 16),
                itemBuilder: (context, index) {
                  final berita = beritaList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade50,
                      child: Icon(
                        Icons.article,
                        color: Colors.deepPurple,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      berita['judul']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      berita['isi']!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // ----------------------------------------------------------
            // E. ROW: Dua Container berwarna (seperti contoh di modul)
            // ----------------------------------------------------------
            const Text(
              'Highlight',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Container 1',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Container 2',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // ============================================================
      // FloatingActionButton
      // ============================================================
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      // ============================================================
      // BottomNavigationBar
      // ============================================================
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Tugas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  // Helper widget: kartu info akademik
  Widget _infoCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

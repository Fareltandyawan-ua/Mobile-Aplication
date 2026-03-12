import 'package:flutter/material.dart';
import 'package:d4tivokasi/features/mahasiswa/data/models/mahasiswa_model.dart';

/// Widget list view mahasiswa
class MahasiswaListView extends StatelessWidget {
  final List<MahasiswaModel> mahasiswaList;
  final VoidCallback? onRefresh;

  const MahasiswaListView({
    Key? key,
    required this.mahasiswaList,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mahasiswaList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Tidak ada data mahasiswa',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {
          return MahasiswaCard(mahasiswa: mahasiswaList[index], index: index);
        },
      ),
    );
  }
}

/// Card individual mahasiswa dengan animasi dan gradient
class MahasiswaCard extends StatefulWidget {
  final MahasiswaModel mahasiswa;
  final int index;

  const MahasiswaCard({Key? key, required this.mahasiswa, required this.index})
    : super(key: key);

  @override
  State<MahasiswaCard> createState() => _MahasiswaCardState();
}

class _MahasiswaCardState extends State<MahasiswaCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // Daftar warna gradient untuk avatar
  final List<List<Color>> _gradients = [
    [Color(0xFF667eea), Color(0xFF764ba2)], // Purple
    [Color(0xFFf093fb), Color(0xFFf5576c)], // Pink
    [Color(0xFF4facfe), Color(0xFF00f2fe)], // Blue
    [Color(0xFF43e97b), Color(0xFF38f9d7)], // Green
    [Color(0xFFfa709a), Color(0xFFfee140)], // Sunset
    [Color(0xFFa18cd1), Color(0xFFfbc2eb)], // Lavender
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> get _cardGradient => _gradients[widget.index % _gradients.length];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _cardGradient[0].withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: _cardGradient[0].withOpacity(0.15),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar dengan gradient
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _cardGradient,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _cardGradient[0].withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.mahasiswa.nama.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Info mahasiswa
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.mahasiswa.nama,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      _buildInfoRow(
                        Icons.badge_outlined,
                        'NIM: ${widget.mahasiswa.nim}',
                      ),
                      const SizedBox(height: 3),
                      _buildInfoRow(
                        Icons.email_outlined,
                        widget.mahasiswa.email,
                      ),
                      const SizedBox(height: 3),
                      _buildInfoRow(
                        Icons.school_outlined,
                        '${widget.mahasiswa.jurusan} • Semester ${widget.mahasiswa.semester}',
                      ),
                    ],
                  ),
                ),
                // Arrow icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _cardGradient[0].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: _cardGradient[0],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey[600]),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

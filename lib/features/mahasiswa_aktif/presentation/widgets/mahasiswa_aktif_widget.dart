import 'package:flutter/material.dart';
import 'package:d4tivokasi/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

/// Widget list view mahasiswa aktif
class MahasiswaAktifListView extends StatelessWidget {
  final List<MahasiswaAktifModel> mahasiswaAktifList;
  final VoidCallback? onRefresh;

  const MahasiswaAktifListView({
    Key? key,
    required this.mahasiswaAktifList,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mahasiswaAktifList.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_off_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Tidak ada mahasiswa aktif',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: CustomScrollView(
        slivers: [
          // Header statistik
          SliverToBoxAdapter(child: _buildStatsHeader(context)),
          // List mahasiswa aktif
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => MahasiswaAktifCard(
                  mahasiswaAktif: mahasiswaAktifList[index],
                  index: index,
                ),
                childCount: mahasiswaAktifList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader(BuildContext context) {
    final avgIpk = mahasiswaAktifList.isEmpty
        ? 0.0
        : mahasiswaAktifList
                  .map((m) => double.tryParse(m.ipk) ?? 0)
                  .reduce((a, b) => a + b) /
              mahasiswaAktifList.length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              'Total Aktif',
              '${mahasiswaAktifList.length}',
              Icons.people_outline_rounded,
            ),
          ),
          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
          Expanded(
            child: _buildStatItem(
              'Rata-rata IPK',
              avgIpk.toStringAsFixed(2),
              Icons.grade_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.9), size: 24),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        ),
      ],
    );
  }
}

/// Card individual mahasiswa aktif
class MahasiswaAktifCard extends StatefulWidget {
  final MahasiswaAktifModel mahasiswaAktif;
  final int index;

  const MahasiswaAktifCard({
    Key? key,
    required this.mahasiswaAktif,
    required this.index,
  }) : super(key: key);

  @override
  State<MahasiswaAktifCard> createState() => _MahasiswaAktifCardState();
}

class _MahasiswaAktifCardState extends State<MahasiswaAktifCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final List<List<Color>> _gradients = [
    [Color(0xFF43e97b), Color(0xFF38f9d7)], // Green
    [Color(0xFF4facfe), Color(0xFF00f2fe)], // Blue
    [Color(0xFF667eea), Color(0xFF764ba2)], // Purple
    [Color(0xFFf093fb), Color(0xFFf5576c)], // Pink
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
                // Avatar
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
                      widget.mahasiswaAktif.nama.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.mahasiswaAktif.nama,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Badge Aktif
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.green.withOpacity(0.5),
                              ),
                            ),
                            child: const Text(
                              'Aktif',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      _buildInfoRow(
                        Icons.badge_outlined,
                        'NIM: ${widget.mahasiswaAktif.nim}',
                      ),
                      const SizedBox(height: 3),
                      _buildInfoRow(
                        Icons.calendar_today_outlined,
                        'Semester ${widget.mahasiswaAktif.semester} • Angkatan ${widget.mahasiswaAktif.tahunMasuk}',
                      ),
                      const SizedBox(height: 3),
                      _buildInfoRow(
                        Icons.grade_outlined,
                        'IPK: ${widget.mahasiswaAktif.ipk}',
                        valueColor: _getIpkColor(widget.mahasiswaAktif.ipk),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
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

  Color _getIpkColor(String ipk) {
    final value = double.tryParse(ipk) ?? 0;
    if (value >= 3.5) return Colors.green;
    if (value >= 3.0) return Colors.orange;
    return Colors.red;
  }

  Widget _buildInfoRow(IconData icon, String text, {Color? valueColor}) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey[600]),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: valueColor ?? Colors.grey[700],
              fontWeight: valueColor != null ? FontWeight.w600 : null,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latlong2;

class RunDetailPage extends StatelessWidget {
  const RunDetailPage({super.key});

  static final latlong2.LatLng _center = latlong2.LatLng(37.7749, -122.4194);

  @override
  Widget build(BuildContext context) {
    const dark = Color(0xFF0D1522);
    const label = Color(0xFF9CA3AF);
    const cardStroke = Color(0x1A0D1522); // subtle border
    const green = Color(0xFF16A34A);
    const greenLight = Color(0xFF7EE18B);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Stack(
        children: [
          // Map background, dimmed to match the grayish Figma look
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(_center.latitude, _center.longitude),
              zoom: 14.5,
            ),
            zoomControlsEnabled: false,
            mapType: MapType.normal,
          ),
          // A soft overlay to mute map colors
          Container(color: const Color(0xCCD1D5DB)),

          // Back arrow on map
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: GestureDetector(
                onTap: () => Navigator.of(context).maybePop(),
                child: const Icon(Icons.arrow_back, color: Colors.black87),
              ),
            ),
          ),

          // Foreground sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: _TopSheet(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with avatars and titles
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _AvatarStack(size: 36),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              _TitleText('Indoor Run'),
                              SizedBox(height: 6),
                              _SubtitleText('20km'),
                            ],
                          ),
                        ),
                        const Icon(Icons.more_vert, color: Colors.black54),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Calories Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: cardStroke),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '1 883 Kcal',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: dark,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Total Kilocalories',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: label,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Mini bar chart
                          SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: _BarChart(
                              values: const [
                                0.3, 0.6, 0.4, 0.55, 0.7, 0.85, 0.45, 0.9, 0.35,
                                0.65, 0.8, 0.5, 0.3, 0.95, 0.7
                              ],
                              colorStart: greenLight,
                              colorEnd: green,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              _Metric(icon: Icons.bolt, label: 'Energy', value: '246'),
                              _Metric(icon: Icons.local_fire_department_rounded, label: 'Flame', value: '682'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Next Round',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: dark,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Next round pill card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: cardStroke),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          // circular gradient icon tile
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [Colors.black, Color(0xFF5B5B5B)],
                              ),
                            ),
                            child: const Icon(Icons.pedal_bike_rounded, color: Colors.white),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: _TileTitle(
                              title: 'Outdoor Cycle',
                              subtitle: '24 min',
                            ),
                          ),
                          const _AvatarStack(size: 28),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopSheet extends StatelessWidget {
  final Widget child;
  const _TopSheet({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // small notch/handle at the top center
          Positioned(
            top: -10,
            child: Container(
              width: 44,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  final double size;
  const _AvatarStack({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 3,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            child: CircleAvatar(
              radius: size / 2,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/seed/userA/120',
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 16, color: Color(0xFF6B7280)),
                ),
              ),
            ),
          ),
          Positioned(
            left: size * 0.75,
            child: CircleAvatar(
              radius: size / 2,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/seed/userB/120',
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 16, color: Color(0xFF6B7280)),
                ),
              ),
            ),
          ),
          Positioned(
            left: size * 1.5,
            child: CircleAvatar(
              radius: size / 2,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/seed/userC/120',
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 16, color: Color(0xFF6B7280)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;
  const _TitleText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: Color(0xFF0D1522),
      ),
    );
  }
}

class _SubtitleText extends StatelessWidget {
  final String text;
  const _SubtitleText(this.text);
  @override
  Widget build(BuildContext context) {
    return const Text(
      '20km',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF9CA3AF),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  final List<double> values; // 0..1
  final Color colorStart;
  final Color colorEnd;
  const _BarChart({required this.values, required this.colorStart, required this.colorEnd});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = constraints.maxWidth / (values.length * 2);
        final maxH = constraints.maxHeight * 0.8;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final v in values) ...[
              Container(
                width: barWidth,
                height: maxH * v,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [colorEnd, colorStart],
                  ),
                ),
              ),
              SizedBox(width: barWidth),
            ]
          ],
        );
      },
    );
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _Metric({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    const labelColor = Color(0xFF9CA3AF);
    const dark = Color(0xFF0D1522);
    const green = Color(0xFF16A34A);
    return Column(
      children: [
        Icon(icon, color: green),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: dark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: labelColor,
          ),
        ),
      ],
    );
  }
}

class _TileTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const _TileTitle({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0D1522),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }
}

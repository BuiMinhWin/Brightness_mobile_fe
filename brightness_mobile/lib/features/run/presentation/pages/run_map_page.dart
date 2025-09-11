import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:brightness_mobile/app/router.dart';

class RunMapPage extends StatelessWidget {
  const RunMapPage({super.key});

  // A light basemap similar to the Figma look
  static const _tileTemplate =
      'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png';

  // Center somewhere generic; adjust as needed
  static final LatLng _center = LatLng(37.7749, -122.4194);

  // Example path coordinates for the dotted routes
  List<LatLng> get _pinkPath => const [
        LatLng(37.7760, -122.4255),
        LatLng(37.7750, -122.4230),
        LatLng(37.7740, -122.4200),
      ];

  List<LatLng> get _blackPath => const [
        LatLng(37.7732, -122.4170),
        LatLng(37.7722, -122.4150),
        LatLng(37.7715, -122.4120),
        LatLng(37.7718, -122.4105),
      ];

  // Create evenly spaced points along each segment for dotted effect
  List<LatLng> _dotsFromPath(List<LatLng> path, {int dotsPerSegment = 10}) {
    final dots = <LatLng>[];
    for (var i = 0; i < path.length - 1; i++) {
      final a = path[i];
      final b = path[i + 1];
      for (var d = 0; d <= dotsPerSegment; d++) {
        final t = d / dotsPerSegment;
        final lat = a.latitude + (b.latitude - a.latitude) * t;
        final lng = a.longitude + (b.longitude - a.longitude) * t;
        dots.add(LatLng(lat, lng));
      }
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pink = const Color(0xFFFF6B8B);
    final dark = const Color(0xFF0D1522);
    final label = const Color(0xFF9CA3AF);
    final statGreenBg = const Color(0xFFE8F7EE);
    final statGreen = const Color(0xFF22C55E);

    // Dots
    final pinkDots = _dotsFromPath(_pinkPath, dotsPerSegment: 10);
    final blackDots = _dotsFromPath(_blackPath, dotsPerSegment: 12);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Stack(
        children: [
          // MAP
          FlutterMap(
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom |
                    InteractiveFlag.drag |
                    InteractiveFlag.doubleTapZoom,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: _tileTemplate,
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.example.brightness_mobile',
              ),
              // Pink dotted route
              CircleLayer(
                circles: [
                  for (final p in pinkDots)
                    CircleMarker(
                      point: p,
                      radius: 3.5,
                      color: pink,
                      borderStrokeWidth: 0,
                    ),
                ],
              ),
              // Black dotted route
              CircleLayer(
                circles: [
                  for (final p in blackDots)
                    CircleMarker(
                      point: p,
                      radius: 3.5,
                      color: Colors.black,
                      borderStrokeWidth: 0,
                    ),
                ],
              ),
              // Markers: big dark location pin and a friend avatar
              MarkerLayer(
                markers: [
                  Marker(
                    point: const LatLng(37.7746, -122.4215),
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          colors: [Colors.black, Color(0xFF444444)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Marker(
                    point: const LatLng(37.7738, -122.4179),
                    width: 40,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(3),
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=256&q=80&auto=format&fit=crop',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Top app bar with back arrow
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(24),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back, size: 24, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Compass floating button
          Positioned(
            right: 24,
            bottom: 220,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.navigation_rounded, color: Colors.black87),
            ),
          ),

          // Bottom card
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(AppRouter.runDetail),
              child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  )
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Overlapped avatars
                      SizedBox(
                        width: 84,
                        height: 36,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: const [
                            _Avatar(url: 'https://images.unsplash.com/photo-1547425260-76bcadfb4f2d?w=120&q=80&auto=format&fit=crop'),
                            _Avatar(offset: 24, url: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=120&q=80&auto=format&fit=crop'),
                            _Avatar(offset: 48, url: 'https://images.unsplash.com/photo-1544005310-0e09f9d6d63f?w=120&q=80&auto=format&fit=crop'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Indoor Run',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: dark,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '20km',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: label,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.more_vert, color: Colors.black54),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: statGreenBg,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(Icons.directions_run_rounded, color: statGreen),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _StatBlock(
                              label: 'Elapsed time',
                              value: '00 : 30 : 24',
                            ),
                            _StatBlock(
                              label: 'Distance',
                              value: '12.5km/20km',
                            ),
                          ],
                        ),
                      ),
                    ],
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

class _Avatar extends StatelessWidget {
  final String url;
  final double offset;
  const _Avatar({required this.url, this.offset = 0});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset,
      top: 0,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CircleAvatar(backgroundImage: NetworkImage(url)),
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String label;
  final String value;
  const _StatBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final labelColor = const Color(0xFF9CA3AF);
    final valueColor = const Color(0xFF0D1522);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: labelColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}

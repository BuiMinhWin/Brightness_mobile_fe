import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:brightness_mobile/app/router.dart';

class RunMapPage extends StatelessWidget {
  const RunMapPage({super.key});

  // Center somewhere generic; adjust as needed
  static final latlong2.LatLng _center = latlong2.LatLng(37.7749, -122.4194);

  // Example path coordinates for the dotted routes
  List<latlong2.LatLng> get _pinkPath => const [
        latlong2.LatLng(37.7760, -122.4255),
        latlong2.LatLng(37.7750, -122.4230),
        latlong2.LatLng(37.7740, -122.4200),
      ];

  List<latlong2.LatLng> get _blackPath => const [
        latlong2.LatLng(37.7732, -122.4170),
        latlong2.LatLng(37.7722, -122.4150),
        latlong2.LatLng(37.7715, -122.4120),
        latlong2.LatLng(37.7718, -122.4105),
      ];

  // Create evenly spaced points along each segment for dotted effect
  List<LatLng> _dotsFromPath(List<latlong2.LatLng> path,
      {int dotsPerSegment = 10}) {
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

  // Helper to build circles for dotted paths
  Set<Circle> _buildCircles(List<LatLng> pinkDots, List<LatLng> blackDots,
      Color pinkColor, Color blackColor) {
    final Set<Circle> circles = {};
    for (int i = 0; i < pinkDots.length; i++) {
      circles.add(
        Circle(
          circleId: CircleId('pink_dot_$i'),
          center: pinkDots[i],
          radius: 3.5,
          fillColor: pinkColor,
          strokeWidth: 0,
        ),
      );
    }
    for (int i = 0; i < blackDots.length; i++) {
      circles.add(
        Circle(
          circleId: CircleId('black_dot_$i'),
          center: blackDots[i],
          radius: 3.5,
          fillColor: blackColor,
          strokeWidth: 0,
        ),
      );
    }
    return circles;
  }

  // Helper to build markers for locations and avatars
  Set<Marker> _buildMarkers(BuildContext context) {
    final Set<Marker> markers = {};
    // Big dark location pin
    markers.add(
      Marker(
        markerId: const MarkerId('location_pin'),
        position: const LatLng(37.7746, -122.4215),
        // Using a default marker icon. For custom widget markers,
        // you would need to render the widget to a BitmapDescriptor.
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        anchor: const Offset(0.5, 0.5),
      ),
    );
    // Friend avatar
    markers.add(
      Marker(
        markerId: const MarkerId('friend_avatar'),
        position: const LatLng(37.7738, -122.4179),
        // Using a default marker icon. For custom widget markers,
        // you would need to render the widget to a BitmapDescriptor.
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pink = const Color(0xFFFF6B8B);
    final dark = const Color(0xFF0D1522);
    final label = const Color(0xFF9CA3AF);
    final statGreenBg = const Color(0xFFE8F7EE);
    final statGreen = const Color(0xFF22C55E);

    // Dots for paths
    final pinkDots = _dotsFromPath(_pinkPath, dotsPerSegment: 10);
    final blackDots = _dotsFromPath(_blackPath, dotsPerSegment: 12);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Stack(
        children: [
          // MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(_center.latitude, _center.longitude),
              zoom: 15,
            ),
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            circles: _buildCircles(pinkDots, blackDots, pink, Colors.black),
            markers: _buildMarkers(context),
            // You can add more interaction options here if needed,
            // e.g., scrollGesturesEnabled, zoomGesturesEnabled.
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
                      child: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Colors.black87,
                      ),
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
                    color: Colors.black.withAlpha(26),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.navigation_rounded,
                color: Colors.black87,
              ),
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
                    ),
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
                              _Avatar(
                                url: 'https://picsum.photos/seed/user1/120',
                              ),
                              _Avatar(
                                offset: 24,
                                url: 'https://picsum.photos/seed/user2/120',
                              ),
                              _Avatar(
                                offset: 48,
                                url: 'https://picsum.photos/seed/user3/120',
                              ),
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
                          child: Icon(
                            Icons.directions_run_rounded,
                            color: statGreen,
                          ),
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
              color: Colors.black.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.network(
            url,
            width: 36,
            height: 36,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.medium,
            errorBuilder: (context, error, stackTrace) => const ColoredBox(
              color: Color(0xFFE5E7EB),
              child: Center(
                child: Icon(Icons.person, size: 16, color: Color(0xFF6B7280)),
              ),
            ),
          ),
        ),
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

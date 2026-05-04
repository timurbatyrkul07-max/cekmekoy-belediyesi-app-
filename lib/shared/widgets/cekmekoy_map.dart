import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class MapMarker {
  final String id;
  final String title;
  final String subtitle;
  final LatLng position;
  final IconData icon;
  final Color color;

  const MapMarker({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.position,
    this.icon = Icons.location_on,
    this.color = AppColors.primary,
  });
}

class CekmekoyMap extends StatefulWidget {
  static const LatLng cekmekoyCenter = LatLng(41.0356, 29.1842);

  final List<MapMarker> markers;
  final LatLng? center;
  final double initialZoom;
  final double height;
  final void Function(MapMarker)? onMarkerTap;

  const CekmekoyMap({
    super.key,
    required this.markers,
    this.center,
    this.initialZoom = 13,
    this.height = 320,
    this.onMarkerTap,
  });

  @override
  State<CekmekoyMap> createState() => _CekmekoyMapState();
}

class _CekmekoyMapState extends State<CekmekoyMap> {
  final _mapController = MapController();
  MapMarker? _selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: widget.center ?? CekmekoyMap.cekmekoyCenter,
                initialZoom: widget.initialZoom,
                onTap: (_, __) => setState(() => _selected = null),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'tr.bel.cekmekoy.cekmekoy_app',
                ),
                MarkerLayer(
                  markers: widget.markers.map((m) {
                    return Marker(
                      point: m.position,
                      width: 44,
                      height: 44,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selected = m);
                          widget.onMarkerTap?.call(m);
                          _mapController.move(m.position, _mapController.camera.zoom);
                        },
                        child: _MarkerPin(color: m.color, icon: m.icon),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          if (_selected != null)
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: _MarkerCard(
                marker: _selected!,
                onClose: () => setState(() => _selected = null),
              ),
            ),
        ],
      ),
    );
  }
}

class _MarkerPin extends StatelessWidget {
  final Color color;
  final IconData icon;
  const _MarkerPin({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.location_on, color: color, size: 44),
        Positioned(
          top: 6,
          child: Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 14),
          ),
        ),
      ],
    );
  }
}

class _MarkerCard extends StatelessWidget {
  final MapMarker marker;
  final VoidCallback onClose;

  const _MarkerCard({required this.marker, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: marker.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(marker.icon, color: marker.color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(marker.title, style: AppTextStyles.bodyBold, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(marker.subtitle,
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.directions, color: AppColors.primary),
              onPressed: () {
                final url =
                    'https://www.google.com/maps/dir/?api=1&destination=${marker.position.latitude},${marker.position.longitude}';
                launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              },
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textTertiary),
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
  }
}

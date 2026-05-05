import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../../shared/widgets/cekmekoy_map.dart';
import '../data/landmarks_api.dart';

class ParkDetailPage extends StatelessWidget {
  final LandmarkItem park;
  const ParkDetailPage({super.key, required this.park});

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: park.name,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: park.coverFilePath != null && park.coverFilePath!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: park.coverUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: AppColors.background),
                    errorWidget: (_, __, ___) => _heroPlaceholder(),
                  )
                : _heroPlaceholder(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('PARK',
                      style: AppTextStyles.caption.copyWith(
                        color: const Color(0xFF10B981),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      )),
                ),
                const SizedBox(height: 8),
                Text(park.name, style: AppTextStyles.h2),
                const SizedBox(height: 16),
                if (park.totalArea != null ||
                    park.constructionYear != null ||
                    park.renovationYear != null)
                  _statsCard(),
                const SizedBox(height: 20),
                if (park.description != null && park.description!.isNotEmpty) ...[
                  Text('HAKKINDA', style: AppTextStyles.sectionLabel),
                  const SizedBox(height: 8),
                  Text(park.description!,
                      style: AppTextStyles.body.copyWith(height: 1.6, fontSize: 14)),
                  const SizedBox(height: 20),
                ],
                if (park.hasLocation) ...[
                  Text('KONUM', style: AppTextStyles.sectionLabel),
                  const SizedBox(height: 8),
                  CekmekoyMap(
                    markers: [
                      MapMarker(
                        id: '${park.id}',
                        title: park.name,
                        subtitle: park.address ?? '',
                        position: LatLng(park.latitude!, park.longitude!),
                        icon: Icons.park,
                        color: const Color(0xFF10B981),
                      ),
                    ],
                    center: LatLng(park.latitude!, park.longitude!),
                    initialZoom: 15,
                    height: 220,
                  ),
                  const SizedBox(height: 12),
                  if (park.address != null && park.address!.isNotEmpty)
                    _row(
                      icon: Icons.location_on,
                      label: 'Adres',
                      value: park.address!,
                    ),
                  const SizedBox(height: 8),
                  if (park.neighborhoodName != null)
                    _row(
                      icon: Icons.map,
                      label: 'Mahalle',
                      value: park.neighborhoodName!,
                    ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final url =
                            'https://www.google.com/maps/dir/?api=1&destination=${park.latitude},${park.longitude}';
                        launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      },
                      icon: const Icon(Icons.directions),
                      label: const Text('Yol Tarifi Al'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ] else if (park.address != null && park.address!.isNotEmpty) ...[
                  Text('ADRES', style: AppTextStyles.sectionLabel),
                  const SizedBox(height: 8),
                  _row(
                    icon: Icons.location_on,
                    label: 'Adres',
                    value: park.address!,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF10B981), Color(0xFF34D399)],
        ),
      ),
      child: const Center(
        child: Icon(Icons.park, size: 80, color: Colors.white54),
      ),
    );
  }

  Widget _statsCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (park.totalArea != null)
            Expanded(
              child: _stat(
                icon: Icons.straighten,
                label: 'Alan',
                value: '${park.totalArea!.toStringAsFixed(0)} m²',
              ),
            ),
          if (park.constructionYear != null)
            Expanded(
              child: _stat(
                icon: Icons.foundation,
                label: 'Yapım',
                value: '${park.constructionYear}',
              ),
            ),
          if (park.renovationYear != null)
            Expanded(
              child: _stat(
                icon: Icons.refresh,
                label: 'Yenileme',
                value: '${park.renovationYear}',
              ),
            ),
        ],
      ),
    );
  }

  Widget _stat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF10B981), size: 24),
        const SizedBox(height: 4),
        Text(value,
            style: AppTextStyles.bodyBold.copyWith(fontSize: 14)),
        Text(label,
            style: AppTextStyles.caption.copyWith(fontSize: 10)),
      ],
    );
  }

  Widget _row({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF10B981), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                Text(value, style: AppTextStyles.bodyBold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

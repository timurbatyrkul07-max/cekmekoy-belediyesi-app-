import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../../shared/widgets/cekmekoy_map.dart';
import '../data/landmarks_api.dart';
import 'park_detail_page.dart';

class ParksPage extends ConsumerWidget {
  const ParksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncParks = ref.watch(parksProvider);
    return BrandedScaffold(
      title: 'Parklarımız',
      child: asyncParks.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Parklar yüklenemedi.\n$e',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
          ),
        ),
        data: (parks) {
          if (parks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.park, size: 64, color: AppColors.textTertiary),
                  const SizedBox(height: 12),
                  Text('Henüz park eklenmemiş', style: AppTextStyles.bodyBold),
                ],
              ),
            );
          }
          final markers = parks
              .where((p) => p.hasLocation)
              .map((p) => MapMarker(
                    id: '${p.id}',
                    title: p.name,
                    subtitle: p.neighborhoodName ?? '',
                    position: LatLng(p.latitude!, p.longitude!),
                    icon: Icons.park,
                    color: const Color(0xFF10B981),
                  ))
              .toList();
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            children: [
              if (markers.isNotEmpty) ...[
                CekmekoyMap(markers: markers, height: 240),
                const SizedBox(height: 16),
              ],
              Text('${parks.length} Park', style: AppTextStyles.bodyBold),
              const SizedBox(height: 12),
              ...parks.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ParkCard(park: p),
                  )),
            ],
          );
        },
      ),
    );
  }
}

class _ParkCard extends StatelessWidget {
  final LandmarkItem park;
  const _ParkCard({required this.park});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ParkDetailPage(park: park)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: park.coverFilePath != null && park.coverFilePath!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: park.coverUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(color: AppColors.background),
                        errorWidget: (_, __, ___) => _placeholder(),
                      )
                    : _placeholder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(park.name, style: AppTextStyles.bodyBold),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      if (park.neighborhoodName != null)
                        _chip(Icons.location_on, park.neighborhoodName!),
                      if (park.totalArea != null)
                        _chip(Icons.straighten,
                            '${park.totalArea!.toStringAsFixed(0)} m²'),
                      if (park.constructionYear != null)
                        _chip(Icons.calendar_today,
                            'Yapım: ${park.constructionYear}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xFF10B981).withValues(alpha: 0.15),
      alignment: Alignment.center,
      child: const Icon(Icons.park, size: 48, color: Color(0xFF10B981)),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColors.textTertiary),
        const SizedBox(width: 4),
        Text(label,
            style: AppTextStyles.caption
                .copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}

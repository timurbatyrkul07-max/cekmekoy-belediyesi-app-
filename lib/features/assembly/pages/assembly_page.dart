import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../../shared/widgets/cekmekoy_map.dart';

class AssemblyArea {
  final String name;
  final String neighborhood;
  final int capacity;
  final LatLng position;

  const AssemblyArea({
    required this.name,
    required this.neighborhood,
    required this.capacity,
    required this.position,
  });
}

class AssemblyPage extends StatelessWidget {
  const AssemblyPage({super.key});

  static const _items = [
    AssemblyArea(
      name: 'Çekmeköy Millet Bahçesi',
      neighborhood: 'Merkez Mh.',
      capacity: 5000,
      position: LatLng(41.0356, 29.1842),
    ),
    AssemblyArea(
      name: 'Mimar Sinan Parkı',
      neighborhood: 'Mimar Sinan Mh.',
      capacity: 1500,
      position: LatLng(41.0410, 29.1920),
    ),
    AssemblyArea(
      name: 'Mehmet Akif Ersoy Parkı',
      neighborhood: 'Mehmet Akif Mh.',
      capacity: 2000,
      position: LatLng(41.0290, 29.1670),
    ),
    AssemblyArea(
      name: 'Hamidiye Mehmetçik Parkı',
      neighborhood: 'Hamidiye Mh.',
      capacity: 1200,
      position: LatLng(41.0470, 29.2010),
    ),
    AssemblyArea(
      name: 'Soğukpınar Tabiat Parkı',
      neighborhood: 'Soğukpınar Mh.',
      capacity: 3000,
      position: LatLng(41.0680, 29.2200),
    ),
    AssemblyArea(
      name: 'Çamlık Botanik Bahçesi',
      neighborhood: 'Çamlık Mh.',
      capacity: 2500,
      position: LatLng(41.0335, 29.1810),
    ),
    AssemblyArea(
      name: 'Taşdelen Aile Parkı',
      neighborhood: 'Taşdelen Mh.',
      capacity: 1800,
      position: LatLng(41.0560, 29.2100),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final markers = _items
        .map((a) => MapMarker(
              id: a.name,
              title: a.name,
              subtitle: '${a.neighborhood} • ${a.capacity} kişi kapasiteli',
              position: a.position,
              icon: Icons.warning_amber,
              color: AppColors.accent,
            ))
        .toList();

    return BrandedScaffold(
      title: 'Toplanma Alanları',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.accent),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Olası bir afet durumunda bulunduğunuz konuma en yakın toplanma alanına gidiniz.',
                    style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CekmekoyMap(markers: markers, height: 280, initialZoom: 12),
          const SizedBox(height: 20),
          Text('${_items.length} Toplanma Alanı', style: AppTextStyles.sectionTitle),
          const SizedBox(height: 12),
          ..._items.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AssemblyCard(item: a),
              )),
        ],
      ),
    );
  }
}

class _AssemblyCard extends StatelessWidget {
  final AssemblyArea item;
  const _AssemblyCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final url =
            'https://www.google.com/maps/dir/?api=1&destination=${item.position.latitude},${item.position.longitude}';
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.warning_amber, color: AppColors.accent, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: AppTextStyles.bodyBold),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 12, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Text(item.neighborhood, style: AppTextStyles.caption),
                      const SizedBox(width: 12),
                      Icon(Icons.people, size: 12, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Text('${item.capacity} kişi', style: AppTextStyles.caption),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.directions, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

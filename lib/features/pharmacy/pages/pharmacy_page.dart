import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../../shared/widgets/cekmekoy_map.dart';

class Pharmacy {
  final String name;
  final String address;
  final String phone;
  final LatLng position;

  const Pharmacy({
    required this.name,
    required this.address,
    required this.phone,
    required this.position,
  });
}

class PharmacyPage extends StatelessWidget {
  const PharmacyPage({super.key});

  static const _items = [
    Pharmacy(
      name: 'Çamlık Eczanesi',
      address: 'Çamlık Mh. Alemdağ Cad. No:12 Çekmeköy',
      phone: '+90 (216) 642 11 22',
      position: LatLng(41.0356, 29.1842),
    ),
    Pharmacy(
      name: 'Mimar Sinan Eczanesi',
      address: 'Mimar Sinan Mh. Vatan Cad. No:48 Çekmeköy',
      phone: '+90 (216) 643 55 80',
      position: LatLng(41.0410, 29.1920),
    ),
    Pharmacy(
      name: 'Hayat Eczanesi',
      address: 'Merkez Mh. İstiklal Cad. No:25 Çekmeköy',
      phone: '+90 (216) 642 78 19',
      position: LatLng(41.0338, 29.1758),
    ),
    Pharmacy(
      name: 'Ekşioğlu Eczanesi',
      address: 'Ekşioğlu Mh. Eski Üsküdar Cad. No:9 Çekmeköy',
      phone: '+90 (216) 484 23 67',
      position: LatLng(41.0285, 29.1690),
    ),
    Pharmacy(
      name: 'Taşdelen Sağlık Eczanesi',
      address: 'Taşdelen Mh. Şile Yolu Cad. No:142 Çekmeköy',
      phone: '+90 (216) 489 90 11',
      position: LatLng(41.0560, 29.2100),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('d MMMM y, EEEE', 'tr_TR').format(DateTime.now());
    final markers = _items
        .map((p) => MapMarker(
              id: p.name,
              title: p.name,
              subtitle: p.address,
              position: p.position,
              icon: Icons.local_pharmacy,
              color: AppColors.primary,
            ))
        .toList();

    return BrandedScaffold(
      title: 'Nöbetçi Eczaneler',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          Text(today, textAlign: TextAlign.center, style: AppTextStyles.h3),
          const SizedBox(height: 12),
          CekmekoyMap(markers: markers, height: 280),
          const SizedBox(height: 20),
          ..._items.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _PharmacyCard(item: p),
              )),
        ],
      ),
    );
  }
}

class _PharmacyCard extends StatelessWidget {
  final Pharmacy item;
  const _PharmacyCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.error, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text('E',
                style: AppTextStyles.h2.copyWith(color: AppColors.error, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTextStyles.bodyBold),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 14, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(item.address,
                          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => launchUrl(
                            Uri.parse('tel:${item.phone.replaceAll(RegExp(r"[^0-9+]"), "")}')),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone, size: 14, color: Colors.white),
                              SizedBox(width: 6),
                              Text('Ara',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          final url =
                              'https://www.google.com/maps/dir/?api=1&destination=${item.position.latitude},${item.position.longitude}';
                          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.directions, size: 14, color: Colors.white),
                              SizedBox(width: 6),
                              Text('Yol Tarifi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

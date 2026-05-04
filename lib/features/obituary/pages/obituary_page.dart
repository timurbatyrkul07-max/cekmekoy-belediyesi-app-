import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';

class ObituaryItem {
  final String name;
  final int birthYear;
  final DateTime deathDate;
  final String neighborhood;
  final String funeralLocation;
  final String funeralTime;
  final String? note;

  const ObituaryItem({
    required this.name,
    required this.birthYear,
    required this.deathDate,
    required this.neighborhood,
    required this.funeralLocation,
    required this.funeralTime,
    this.note,
  });
}

class ObituaryPage extends StatelessWidget {
  const ObituaryPage({super.key});

  static final _items = [
    ObituaryItem(
      name: 'Mehmet YILMAZ',
      birthYear: 1948,
      deathDate: DateTime(2026, 5, 4),
      neighborhood: 'Merkez Mh.',
      funeralLocation: 'Merkez Camii',
      funeralTime: 'Öğle Namazı',
      note: 'Allah rahmet eylesin.',
    ),
    ObituaryItem(
      name: 'Ayşe DEMİR',
      birthYear: 1955,
      deathDate: DateTime(2026, 5, 4),
      neighborhood: 'Mimar Sinan Mh.',
      funeralLocation: 'Mimar Sinan Camii',
      funeralTime: 'İkindi Namazı',
    ),
    ObituaryItem(
      name: 'İbrahim KAYA',
      birthYear: 1942,
      deathDate: DateTime(2026, 5, 3),
      neighborhood: 'Hamidiye Mh.',
      funeralLocation: 'Hamidiye Camii',
      funeralTime: 'Öğle Namazı',
    ),
    ObituaryItem(
      name: 'Fatma ÖZTÜRK',
      birthYear: 1960,
      deathDate: DateTime(2026, 5, 2),
      neighborhood: 'Çamlık Mh.',
      funeralLocation: 'Çamlık Camii',
      funeralTime: 'Öğle Namazı',
    ),
    ObituaryItem(
      name: 'Hasan ÇELİK',
      birthYear: 1939,
      deathDate: DateTime(2026, 5, 2),
      neighborhood: 'Taşdelen Mh.',
      funeralLocation: 'Taşdelen Merkez Camii',
      funeralTime: 'İkindi Namazı',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Vefat İlanları',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Hemşehrilerimizin vefat haberleri günceldir. Vefat duyurusu için belediyemize başvurabilirsiniz.',
                    style: AppTextStyles.caption.copyWith(height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ..._items.map((it) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ObituaryCard(item: it),
              )),
        ],
      ),
    );
  }
}

class _ObituaryCard extends StatelessWidget {
  final ObituaryItem item;
  const _ObituaryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final age = item.deathDate.year - item.birthYear;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.church, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: AppTextStyles.bodyBold.copyWith(fontSize: 16)),
                    const SizedBox(height: 2),
                    Text(
                      '${item.birthYear} • $age yaşında • ${item.neighborhood}',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          _row(
            icon: Icons.calendar_today,
            label: 'Vefat Tarihi',
            value: DateFormat('d MMMM y, EEEE', 'tr_TR').format(item.deathDate),
          ),
          const SizedBox(height: 8),
          _row(
            icon: Icons.location_on,
            label: 'Cenaze Yeri',
            value: item.funeralLocation,
          ),
          const SizedBox(height: 8),
          _row(
            icon: Icons.access_time,
            label: 'Cenaze Vakti',
            value: item.funeralTime,
          ),
          if (item.note != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '"${item.note!}"',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _row({required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textTertiary),
        const SizedBox(width: 8),
        Text('$label:', style: AppTextStyles.caption),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

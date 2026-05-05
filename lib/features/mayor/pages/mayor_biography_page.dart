import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';

class MayorBiographyPage extends StatelessWidget {
  const MayorBiographyPage({super.key});

  static const _bio = [
    _Item('Doğum', '1962, Ardahan'),
    _Item('İkamet', '1980\'den itibaren Çekmeköy'),
    _Item('Medeni Hâl', 'Evli, 2 çocuk babası'),
  ];

  static const _education = [
    _Item('Lisans', 'Anadolu Üniversitesi, İktisadi ve İdari Bilimler Fakültesi, İşletme Bölümü'),
    _Item('Yüksek Lisans', 'İstanbul Medeniyet Üniversitesi, Kamu Yönetimi ve Şehircilik'),
  ];

  static const _career = [
    _Career('2009-2016', 'Ataşehir Belediyesi', 'İdari İşler Sorumlusu, Ulaşım Hizmetleri Müdürü'),
    _Career('2016-2023', 'Ataşehir Belediyesi', 'Belediye Başkan Yardımcısı'),
    _Career('2024-...', 'Çekmeköy Belediyesi', 'Belediye Başkanı'),
  ];

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Özgeçmiş',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          Center(
            child: ClipOval(
              child: Image.asset(AppStrings.mayorPhoto, width: 140, height: 140, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.h2,
                children: const [
                  TextSpan(text: 'Orhan ', style: TextStyle(color: AppColors.primary)),
                  TextSpan(text: 'ÇERKEZ', style: TextStyle(color: AppColors.accent)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(AppStrings.mayorTitle,
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
          ),
          const SizedBox(height: 28),
          _SectionCard(title: 'Kişisel Bilgiler', items: _bio),
          const SizedBox(height: 16),
          _SectionCard(title: 'Eğitim', items: _education),
          const SizedBox(height: 16),
          _CareerSection(items: _career),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.emoji_events, color: AppColors.accent),
                    const SizedBox(width: 8),
                    Text('Tarihi Başarı', style: AppTextStyles.bodyBold),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Orhan Çerkez, 31 Mart 2024 yerel seçimlerinde Çekmeköy tarihinin en yüksek oy oranıyla seçilen belediye başkanı oldu.',
                  style: AppTextStyles.body.copyWith(height: 1.5, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Item {
  final String label;
  final String value;
  const _Item(this.label, this.value);
}

class _Career {
  final String period;
  final String institution;
  final String role;
  const _Career(this.period, this.institution, this.role);
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<_Item> items;
  const _SectionCard({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: AppTextStyles.sectionLabel),
          const SizedBox(height: 12),
          ...items.map((it) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(it.label,
                          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                    ),
                    Expanded(
                      child: Text(it.value,
                          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _CareerSection extends StatelessWidget {
  final List<_Career> items;
  const _CareerSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('KARİYER', style: AppTextStyles.sectionLabel),
          const SizedBox(height: 12),
          ...List.generate(items.length, (i) {
            final c = items[i];
            final isLast = i == items.length - 1;
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: isLast ? AppColors.accent : AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(width: 2, color: AppColors.divider),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.period,
                              style: AppTextStyles.bodyBold.copyWith(color: AppColors.primary)),
                          Text(c.institution, style: AppTextStyles.bodyBold),
                          Text(c.role,
                              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

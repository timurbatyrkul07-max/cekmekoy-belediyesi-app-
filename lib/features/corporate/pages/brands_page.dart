import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../data/corporate_data.dart';

class BrandsPage extends StatelessWidget {
  const BrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Çekmeköy Markaları',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Sosyal belediyeciliğin somut çıktıları', style: AppTextStyles.sectionLabel),
          const SizedBox(height: 12),
          ...CorporateData.brands.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _BrandCard(brand: b),
              )),
        ],
      ),
    );
  }
}

class _BrandCard extends StatelessWidget {
  final Brand brand;
  const _BrandCard({required this.brand});

  Color get _categoryColor {
    return switch (brand.category) {
      'Eğitim' => AppColors.primary,
      'Sosyal Hizmet' => AppColors.accent,
      'Spor' => AppColors.success,
      'Çevre' => const Color(0xFF10B981),
      _ => AppColors.primary,
    };
  }

  IconData get _categoryIcon {
    return switch (brand.category) {
      'Eğitim' => Icons.school,
      'Sosyal Hizmet' => Icons.volunteer_activism,
      'Spor' => Icons.sports,
      'Çevre' => Icons.eco,
      _ => Icons.star,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _categoryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_categoryIcon, color: _categoryColor, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _categoryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    brand.category.toUpperCase(),
                    style: AppTextStyles.caption.copyWith(
                      color: _categoryColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(brand.name, style: AppTextStyles.bodyBold),
                const SizedBox(height: 2),
                Text(brand.description,
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

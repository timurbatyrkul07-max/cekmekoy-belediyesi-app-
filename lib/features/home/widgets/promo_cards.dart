import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class PromoCards extends StatelessWidget {
  const PromoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Expanded(
            child: _PromoCard(
              title: 'Çekmeköy\nKent Lokantası',
              icon: Icons.restaurant,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _PromoCard(
              title: 'Çekmeköy\nAkademi',
              icon: Icons.school,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _PromoCard({required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

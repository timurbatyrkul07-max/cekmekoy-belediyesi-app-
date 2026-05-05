import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../data/corporate_data.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  final bool detailed;
  final VoidCallback? onTap;

  const PersonCard({super.key, required this.person, this.detailed = true, this.onTap});

  Color get _partyColor {
    return switch (person.party) {
      'CHP' => const Color(0xFFE30A17),
      'AK Parti' => const Color(0xFFFF6B00),
      'İYİ Parti' => const Color(0xFF1B6FBA),
      _ => AppColors.textTertiary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _initials(person.name),
                    style: AppTextStyles.bodyBold.copyWith(
                      color: AppColors.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(person.name, style: AppTextStyles.bodyBold),
                    const SizedBox(height: 2),
                    Text(person.title,
                        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              if (person.party != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _partyColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    person.party!,
                    style: AppTextStyles.caption.copyWith(
                      color: _partyColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          if (detailed && person.department != null) ...[
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.business_center, size: 14, color: AppColors.textTertiary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(person.department!,
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                ),
              ],
            ),
          ],
          if (detailed && (person.phone != null || person.email != null)) ...[
            const SizedBox(height: 8),
            const Divider(height: 1),
            const SizedBox(height: 8),
            if (person.phone != null)
              InkWell(
                onTap: () => launchUrl(
                    Uri.parse('tel:${person.phone!.replaceAll(RegExp(r"[^0-9+]"), "")}')),
                child: Row(
                  children: [
                    const Icon(Icons.phone, size: 14, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(person.phone!,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            if (person.email != null) ...[
              const SizedBox(height: 4),
              InkWell(
                onTap: () => launchUrl(Uri.parse('mailto:${person.email}')),
                child: Row(
                  children: [
                    const Icon(Icons.mail_outline, size: 14, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(person.email!,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: card,
        ),
      );
    }
    return card;
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return '${parts[0][0]}${parts.last[0]}'.toUpperCase();
  }
}

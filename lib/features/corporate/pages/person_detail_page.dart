import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../data/corporate_data.dart';

class PersonDetailPage extends StatelessWidget {
  final Person person;
  const PersonDetailPage({super.key, required this.person});

  String get _initials {
    final parts = person.name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return '${parts[0][0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: person.title,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primary, AppColors.primaryLight],
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _initials,
                      style: AppTextStyles.h1.copyWith(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(person.name,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h2.copyWith(color: Colors.white)),
                const SizedBox(height: 4),
                Text(person.title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(color: Colors.white70)),
                if (person.department != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(person.department!,
                        style: AppTextStyles.caption.copyWith(color: Colors.white)),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (person.bio != null && person.bio!.isNotEmpty) ...[
                  Text('ÖZGEÇMİŞ', style: AppTextStyles.sectionLabel),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      person.bio!,
                      style: AppTextStyles.body.copyWith(height: 1.6, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                if (person.phone != null || person.email != null) ...[
                  Text('İLETİŞİM', style: AppTextStyles.sectionLabel),
                  const SizedBox(height: 10),
                  if (person.phone != null) ...[
                    _row(
                      icon: Icons.phone,
                      label: 'Telefon',
                      value: person.phone!,
                      onTap: () => launchUrl(Uri.parse(
                          'tel:${person.phone!.replaceAll(RegExp(r"[^0-9+]"), "")}')),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (person.email != null) ...[
                    _row(
                      icon: Icons.mail_outline,
                      label: 'E-posta',
                      value: person.email!,
                      onTap: () => launchUrl(Uri.parse('mailto:${person.email}')),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppTextStyles.caption),
                    Text(value,
                        style: AppTextStyles.bodyBold.copyWith(
                          color: AppColors.primary,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

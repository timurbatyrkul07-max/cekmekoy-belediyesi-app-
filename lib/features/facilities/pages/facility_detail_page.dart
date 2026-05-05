import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../data/facilities_api.dart';

class FacilityDetailPage extends StatelessWidget {
  final FacilityItem item;
  const FacilityDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: item.name,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (item.coverFilePath != null && item.coverFilePath!.isNotEmpty)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: item.coverUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.background),
                errorWidget: (_, __, ___) => _heroPlaceholder(),
              ),
            )
          else
            AspectRatio(aspectRatio: 16 / 9, child: _heroPlaceholder()),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.typeName != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(item.typeName!.toUpperCase(),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.accent,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        )),
                  ),
                  const SizedBox(height: 8),
                ],
                Text(item.name, style: AppTextStyles.h2),
                const SizedBox(height: 24),
                if (item.operatingHours != null && item.operatingHours!.isNotEmpty) ...[
                  Text('ÇALIŞMA SAATLERİ', style: AppTextStyles.sectionLabel),
                  const SizedBox(height: 10),
                  _hoursCard(item.operatingHours!),
                  const SizedBox(height: 20),
                ],
                if (item.address != null || item.phone != null) ...[
                  Text('İLETİŞİM', style: AppTextStyles.sectionLabel),
                  const SizedBox(height: 10),
                  if (item.address != null && item.address!.isNotEmpty) ...[
                    _row(
                      icon: Icons.location_on,
                      label: 'Adres',
                      value: item.address!,
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (item.phone != null && item.phone!.isNotEmpty)
                    _row(
                      icon: Icons.phone,
                      label: 'Telefon',
                      value: item.phone!,
                      onTap: () => launchUrl(Uri.parse(
                          'tel:${item.phone!.replaceAll(RegExp(r"[^0-9+]"), "")}')),
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
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
      ),
      child: const Center(
        child: Icon(Icons.business, size: 80, color: Colors.white54),
      ),
    );
  }

  Widget _hoursCard(String hours) {
    final lines = hours.split('\n').where((l) => l.trim().isNotEmpty).toList();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: lines.map((line) {
          final parts = line.split(':');
          if (parts.length < 2) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(line.trim(), style: AppTextStyles.body),
            );
          }
          final day = parts[0].trim();
          final time = parts.sublist(1).join(':').trim();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                SizedBox(
                  width: 110,
                  child: Text(day,
                      style: AppTextStyles.body
                          .copyWith(fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Text(time,
                      style: AppTextStyles.body
                          .copyWith(color: AppColors.textSecondary)),
                ),
              ],
            ),
          );
        }).toList(),
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
                          color:
                              onTap != null ? AppColors.primary : AppColors.textPrimary,
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

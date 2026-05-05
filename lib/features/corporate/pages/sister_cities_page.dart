import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../data/corporate_data.dart';

class SisterCitiesPage extends StatelessWidget {
  const SisterCitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Kardeş Şehirler',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.public, color: AppColors.accent),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Çekmeköy Belediyesi olarak ${CorporateData.sisterCities.length} farklı şehir ile kardeşlik bağı kurmuş bulunuyoruz.',
                    style: AppTextStyles.caption.copyWith(height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...CorporateData.sisterCities.map((c) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _CityCard(city: c),
              )),
        ],
      ),
    );
  }
}

class _CityCard extends StatelessWidget {
  final SisterCity city;
  const _CityCard({required this.city});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => SisterCityDetailPage(city: city)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.location_city, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(city.city,
                            style: AppTextStyles.bodyBold.copyWith(fontSize: 15)),
                        Row(
                          children: [
                            const Icon(Icons.flag,
                                size: 12, color: AppColors.textTertiary),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(city.country,
                                  style: AppTextStyles.caption,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.textTertiary),
                ],
              ),
              const SizedBox(height: 10),
              Text(city.description,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class SisterCityDetailPage extends StatelessWidget {
  final SisterCity city;
  const SisterCityDetailPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: city.city,
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
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.location_city,
                      color: Colors.white, size: 48),
                ),
                const SizedBox(height: 16),
                Text(city.city,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h2.copyWith(color: Colors.white)),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.flag, size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(city.country,
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(color: AppColors.accent, width: 4),
                    ),
                  ),
                  child: Text(
                    '"${city.description}"',
                    style: AppTextStyles.body.copyWith(
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text('HAKKINDA', style: AppTextStyles.sectionLabel),
                const SizedBox(height: 8),
                Text(
                  city.detail ?? city.description,
                  style: AppTextStyles.body.copyWith(height: 1.6, fontSize: 14),
                ),
                if (city.sisterSince != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kardeşlik Tarihi',
                                  style: AppTextStyles.caption),
                              Text('${city.sisterSince}',
                                  style: AppTextStyles.bodyBold.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

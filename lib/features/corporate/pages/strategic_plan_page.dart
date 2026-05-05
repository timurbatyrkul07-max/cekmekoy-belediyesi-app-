import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../publications/data/publications_api.dart';

class StrategicPlanPage extends ConsumerWidget {
  const StrategicPlanPage({super.key});

  static const _goals = [
    ('Sürdürülebilir Çevre', 'Yeşil alanları artırmak, sıfır atık projesini yaygınlaştırmak.', Icons.eco),
    ('Modern Altyapı', 'Yol, kaldırım ve otopark altyapısını yenilemek; akıllı şehir uygulamaları.', Icons.construction),
    ('Sosyal Belediyecilik', 'Engelli, yaşlı ve dezavantajlı gruplara yönelik kapsayıcı hizmetler.', Icons.diversity_3),
    ('Eğitim ve Kültür', 'Çekmeköy Akademi, kütüphaneler ve kültür merkezleri ile öğrenmeyi sürdürmek.', Icons.school),
    ('Şeffaf Yönetim', 'Vatandaşın yönetime katılımını artırmak, hesap verebilirlik standartları.', Icons.visibility),
    ('Dijital Belediye', 'Mobil uygulama, e-belediye ve KEOS gibi dijital servisler.', Icons.smartphone),
    ('Sağlıklı Kent', 'Spor okulları, sosyal tesisler ve sağlık programları.', Icons.favorite),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(publicationsListProvider);

    return BrandedScaffold(
      title: 'Stratejik Plan',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stratejik Plan & Performans Programı',
                    style: AppTextStyles.h2.copyWith(color: Colors.white, fontSize: 20)),
                const SizedBox(height: 8),
                Text(
                  'Belediyemizin uzun vadeli vizyonu, hedefleri ve performans göstergelerini içeren resmi belgelerimiz.',
                  style: AppTextStyles.body.copyWith(color: Colors.white70, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('STRATEJİK HEDEFLERİMİZ', style: AppTextStyles.sectionLabel),
          const SizedBox(height: 12),
          ..._goals.map((g) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(g.$3, color: AppColors.accent, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(g.$1, style: AppTextStyles.bodyBold),
                            const SizedBox(height: 4),
                            Text(g.$2,
                                style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary, height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 24),
          Text('RESMİ BELGELER', style: AppTextStyles.sectionLabel),
          const SizedBox(height: 4),
          Text('Stratejik Plan ve Performans Programı belgeleri',
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          asyncList.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => _emptyDocs('Belgeler şu an yüklenemiyor'),
            data: (publications) {
              final docs = publications
                  .where((p) =>
                      p.typeName?.toLowerCase().contains('plan') == true ||
                      p.typeName?.toLowerCase().contains('performans') == true ||
                      p.typeName?.toLowerCase().contains('faaliyet') == true ||
                      p.typeName?.toLowerCase().contains('rapor') == true)
                  .toList();
              if (docs.isEmpty) {
                return _emptyDocs('Belgeler henüz yüklenmemiş');
              }
              return Column(
                children: docs
                    .map((d) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _DocCard(item: d),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _emptyDocs(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppColors.textTertiary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message, style: AppTextStyles.caption),
          ),
        ],
      ),
    );
  }
}

class _DocCard extends StatelessWidget {
  final PublicationItem item;
  const _DocCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          if (item.publicUrl != null) {
            launchUrl(Uri.parse(item.publicUrl!), mode: LaunchMode.externalApplication);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 56,
                  height: 76,
                  child: item.coverFilePath != null && item.coverFilePath!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: item.coverUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, __) =>
                              Container(color: AppColors.background),
                          errorWidget: (_, __, ___) => _docIcon(),
                        )
                      : _docIcon(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.typeName != null)
                      Text(item.typeName!.toUpperCase(),
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.accent,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          )),
                    const SizedBox(height: 2),
                    Text(item.name, style: AppTextStyles.bodyBold),
                  ],
                ),
              ),
              const Icon(Icons.open_in_new,
                  color: AppColors.textTertiary, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _docIcon() {
    return Container(
      color: AppColors.primary.withValues(alpha: 0.12),
      alignment: Alignment.center,
      child: const Icon(Icons.description, color: AppColors.primary),
    );
  }
}

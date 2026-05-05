import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../publications/data/publications_api.dart';

class PublicationsPage extends ConsumerWidget {
  const PublicationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCats = ref.watch(publicationCategoriesProvider);
    final asyncList = ref.watch(publicationsListProvider);

    return BrandedScaffold(
      title: 'Yayınlarımız',
      child: asyncCats.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _error(e.toString()),
        data: (categories) {
          return asyncList.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => _error(e.toString()),
            data: (publications) {
              if (categories.isEmpty && publications.isEmpty) return _empty();
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  for (final cat in categories) ...[
                    _CategoryHeader(category: cat),
                    const SizedBox(height: 10),
                    ...publications
                        .where((p) => p.type == cat.id)
                        .map((p) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _PublicationCard(item: p),
                            )),
                    if (publications.where((p) => p.type == cat.id).isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Bu kategoride henüz yayın eklenmemiş.',
                          style: AppTextStyles.caption
                              .copyWith(color: AppColors.textTertiary),
                        ),
                      ),
                    const SizedBox(height: 16),
                  ],
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _empty() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu_book, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text('Henüz yayın eklenmemiş', style: AppTextStyles.bodyBold),
          ],
        ),
      );

  Widget _error(String e) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('Yüklenemedi.\n$e',
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
        ),
      );
}

class _CategoryHeader extends StatelessWidget {
  final PublicationCategory category;
  const _CategoryHeader({required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(category.name.toUpperCase(),
              style: AppTextStyles.sectionLabel.copyWith(color: AppColors.primary)),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${category.count}',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.accent,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PublicationCard extends StatelessWidget {
  final PublicationItem item;
  const _PublicationCard({required this.item});

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
                  width: 60,
                  height: 80,
                  child: item.coverFilePath != null && item.coverFilePath!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: item.coverUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(color: AppColors.background),
                          errorWidget: (_, __, ___) => _bookIcon(),
                        )
                      : _bookIcon(),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.typeName != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(item.typeName!.toUpperCase(),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.accent,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            )),
                      ),
                    const SizedBox(height: 4),
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

  Widget _bookIcon() {
    return Container(
      color: AppColors.primary.withValues(alpha: 0.12),
      alignment: Alignment.center,
      child: const Icon(Icons.menu_book, color: AppColors.primary),
    );
  }
}

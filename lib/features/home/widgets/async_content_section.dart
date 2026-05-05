import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/content_item.dart';
import 'horizontal_content_section.dart';

class AsyncContentSection extends ConsumerWidget {
  final String title;
  final FutureProvider<List<ContentItem>> provider;
  final List<ContentItem> fallback;
  final bool showDate;

  const AsyncContentSection({
    super.key,
    required this.title,
    required this.provider,
    required this.fallback,
    this.showDate = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(provider);
    return async.when(
      loading: () => _SkeletonSection(title: title),
      error: (e, _) => HorizontalContentSection(
        title: title,
        items: fallback,
        showDate: showDate,
      ),
      data: (items) {
        if (items.isEmpty) return _EmptySection(title: title);
        return HorizontalContentSection(
          title: title,
          items: items,
          showDate: showDate,
        );
      },
    );
  }
}

class _SkeletonSection extends StatelessWidget {
  final String title;
  const _SkeletonSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text(title, style: AppTextStyles.sectionTitle),
        ),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, __) => Container(
              width: 240,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptySection extends StatelessWidget {
  final String title;
  const _EmptySection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.sectionTitle),
          const SizedBox(height: 12),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text('Henüz $title yok',
                style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
          ),
        ],
      ),
    );
  }
}

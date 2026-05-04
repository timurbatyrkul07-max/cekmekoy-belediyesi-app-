import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../models/content_item.dart';
import 'branded_scaffold.dart';
import 'content_detail_page.dart';

class CardListPage extends StatelessWidget {
  final String title;
  final List<ContentItem> items;
  final bool showDate;

  const CardListPage({
    super.key,
    required this.title,
    required this.items,
    this.showDate = true,
  });

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: title,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) => _Card(item: items[i], showDate: showDate),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final ContentItem item;
  final bool showDate;

  const _Card({required this.item, required this.showDate});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ContentDetailPage(item: item)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.surface),
                errorWidget: (_, __, ___) => Container(color: AppColors.surface),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.category != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.category!.toUpperCase(),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(item.title, style: AppTextStyles.bodyBold, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Text(item.summary,
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  if (showDate) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 12, color: AppColors.textTertiary),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('d MMMM y', 'tr_TR').format(item.date),
                          style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary, fontSize: 11),
                        ),
                        if (item.location != null) ...[
                          const SizedBox(width: 12),
                          const Icon(Icons.location_on, size: 12, color: AppColors.textTertiary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              item.location!,
                              style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary, fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

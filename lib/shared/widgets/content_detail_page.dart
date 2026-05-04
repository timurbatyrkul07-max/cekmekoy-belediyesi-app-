import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../models/content_item.dart';

class ContentDetailPage extends StatelessWidget {
  final ContentItem item;
  const ContentDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.primary,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: item.title));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Başlık kopyalandı')),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: AppColors.primary),
                    errorWidget: (_, __, ___) => Container(color: AppColors.primary),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                        ],
                        stops: const [0, 0.5, 1],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (item.category != null)
                        _chip(
                          item.category!,
                          AppColors.accent,
                          AppColors.accent.withValues(alpha: 0.15),
                        ),
                      _chip(
                        DateFormat('d MMMM y', 'tr_TR').format(item.date),
                        AppColors.primary,
                        AppColors.primary.withValues(alpha: 0.1),
                        icon: Icons.calendar_today,
                      ),
                      if (item.location != null)
                        _chip(
                          item.location!,
                          AppColors.primary,
                          AppColors.primary.withValues(alpha: 0.1),
                          icon: Icons.location_on,
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(item.title, style: AppTextStyles.h1),
                  const SizedBox(height: 12),
                  Text(item.summary,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      )),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 20),
                  Text(item.body, style: AppTextStyles.body.copyWith(height: 1.6, fontSize: 15)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, Color fg, Color bg, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(label,
              style: AppTextStyles.caption.copyWith(color: fg, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

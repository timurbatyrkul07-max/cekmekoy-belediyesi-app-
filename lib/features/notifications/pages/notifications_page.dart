import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/app_notification.dart';
import '../../../shared/widgets/branded_scaffold.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(notificationListProvider);

    return BrandedScaffold(
      title: 'Bildirimler',
      child: Column(
        children: [
          if (items.any((n) => !n.read))
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => ref.read(notificationListProvider.notifier).markAllRead(),
                    icon: const Icon(Icons.done_all, size: 18, color: AppColors.primary),
                    label: Text('Tümünü okundu işaretle',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ],
              ),
            ),
          Expanded(
            child: items.isEmpty
                ? _empty()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => _NotificationCard(
                      item: items[i],
                      onTap: () => ref.read(notificationListProvider.notifier).markAsRead(items[i].id),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _empty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.notifications_off, size: 64, color: AppColors.textTertiary),
          const SizedBox(height: 16),
          Text('Henüz bildiriminiz yok', style: AppTextStyles.bodyBold),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final AppNotification item;
  final VoidCallback onTap;

  const _NotificationCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isUnread = !item.read;
    final color = _categoryColor(item.category);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUnread ? AppColors.primary.withValues(alpha: 0.04) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: isUnread
              ? Border.all(color: AppColors.primary.withValues(alpha: 0.2))
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_categoryIcon(item.category), color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.category.label.toUpperCase(),
                          style: AppTextStyles.caption.copyWith(
                            color: color,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(item.date),
                        style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(item.title,
                      style: AppTextStyles.bodyBold.copyWith(
                        fontWeight: isUnread ? FontWeight.w700 : FontWeight.w500,
                      )),
                  const SizedBox(height: 4),
                  Text(item.body,
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
            if (isUnread) ...[
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);
    if (diff.inMinutes < 1) return 'Az önce';
    if (diff.inHours < 1) return '${diff.inMinutes} dk önce';
    if (diff.inDays < 1) return '${diff.inHours} sa önce';
    if (diff.inDays < 7) return '${diff.inDays} gün önce';
    return DateFormat('d MMM y', 'tr_TR').format(d);
  }

  static IconData _categoryIcon(NotificationCategory cat) => switch (cat) {
        NotificationCategory.announcement => Icons.campaign,
        NotificationCategory.news => Icons.newspaper,
        NotificationCategory.event => Icons.event,
        NotificationCategory.reminder => Icons.alarm,
        NotificationCategory.payment => Icons.credit_card,
        NotificationCategory.request => Icons.send,
      };

  static Color _categoryColor(NotificationCategory cat) => switch (cat) {
        NotificationCategory.announcement => AppColors.primary,
        NotificationCategory.news => AppColors.primary,
        NotificationCategory.event => AppColors.accent,
        NotificationCategory.reminder => AppColors.warning,
        NotificationCategory.payment => AppColors.error,
        NotificationCategory.request => AppColors.success,
      };
}

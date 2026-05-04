import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/app_notification.dart';
import '../../../shared/widgets/branded_scaffold.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabledAsync = ref.watch(notificationsEnabledProvider);

    return BrandedScaffold(
      title: 'Ayarlar',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section('Bildirimler'),
          enabledAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Text('Hata: $e'),
            data: (enabled) => _toggleTile(
              context: context,
              icon: Icons.notifications,
              title: 'Bildirim Al',
              subtitle: 'Yeni duyuru, etkinlik ve hatırlatmalar',
              value: enabled,
              onChanged: (v) => ref.read(notificationsEnabledProvider.notifier).toggle(v),
            ),
          ),
          const SizedBox(height: 8),
          _testNotificationButton(ref),
          const SizedBox(height: 24),
          _section('Uygulama'),
          _navTile(icon: Icons.color_lens, title: 'Tema', subtitle: 'Açık (sistem)', onTap: () {}),
          _navTile(icon: Icons.language, title: 'Dil', subtitle: 'Türkçe', onTap: () {}),
          _navTile(icon: Icons.info_outline, title: 'Uygulama Hakkında', subtitle: 'Sürüm 1.0.0', onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'Çekmeköy Belediyesi',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2026 Çekmeköy Belediyesi',
            );
          }),
          const SizedBox(height: 24),
          _section('Yasal'),
          _navTile(icon: Icons.security, title: 'KVKK Aydınlatma Metni', onTap: () {}),
          _navTile(icon: Icons.policy, title: 'Gizlilik Politikası', onTap: () {}),
          _navTile(icon: Icons.gavel, title: 'Kullanım Şartları', onTap: () {}),
        ],
      ),
    );
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 12, 4, 8),
        child: Text(title.toUpperCase(), style: AppTextStyles.sectionLabel),
      );

  Widget _toggleTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        secondary: Icon(icon, color: AppColors.primary),
        title: Text(title, style: AppTextStyles.bodyBold),
        subtitle: Text(subtitle, style: AppTextStyles.caption),
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
    );
  }

  Widget _navTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primary),
          title: Text(title, style: AppTextStyles.bodyBold),
          subtitle: subtitle != null ? Text(subtitle, style: AppTextStyles.caption) : null,
          trailing: const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _testNotificationButton(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: OutlinedButton.icon(
        onPressed: () async {
          final service = ref.read(notificationServiceProvider);
          final notification = AppNotification(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            category: NotificationCategory.announcement,
            title: 'Test Bildirimi',
            body: 'Bildirim sistemi başarıyla çalışıyor!',
            date: DateTime.now(),
          );
          await service.show(notification);
          ref.read(notificationListProvider.notifier).addLocal(notification);
        },
        icon: const Icon(Icons.send, size: 18),
        label: const Text('Test Bildirimi Gönder'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

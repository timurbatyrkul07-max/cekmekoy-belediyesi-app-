import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import 'mayor_biography_page.dart';
import 'mayor_contact_page.dart';
import 'mayor_message_page.dart';
import 'mayor_photos_page.dart';

class MayorPage extends StatelessWidget {
  const MayorPage({super.key});

  static const _officePhone = '+90 (216) 600 0600';
  static const _officePhoneDial = '+902166000600';
  static const _email = 'baskan@cekmekoy.bel.tr';
  static const _website = 'orhancerkez.com.tr';

  static const _instagram = 'https://www.instagram.com/orhanncerkez/';
  static const _twitter = 'https://twitter.com/orhanncerkez';
  static const _facebook = 'https://www.facebook.com/orhanncerkez';
  static const _youtube = 'https://www.youtube.com/@orhanncerkez';

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Başkan',
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHero(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.h1,
                    children: const [
                      TextSpan(text: 'Orhan ', style: TextStyle(color: AppColors.primary)),
                      TextSpan(text: 'ÇERKEZ', style: TextStyle(color: AppColors.accent)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(AppStrings.mayorTitle,
                    style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 24),
                Text(AppStrings.socialMediaTitle, style: AppTextStyles.bodyBold),
                const SizedBox(height: 12),
                _socialRow(),
                const SizedBox(height: 24),
                const Divider(height: 1),
                const SizedBox(height: 16),
                Text('İletişim', style: AppTextStyles.bodyBold),
                const SizedBox(height: 12),
                _contactRow(
                  icon: Icons.phone,
                  label: 'Ofis Telefonu',
                  value: _officePhone,
                  onTap: () => launchUrl(Uri.parse('tel:$_officePhoneDial')),
                ),
                const SizedBox(height: 10),
                _contactRow(
                  icon: Icons.mail_outline,
                  label: 'E-posta Adresi',
                  value: _email,
                  onTap: () => launchUrl(Uri.parse('mailto:$_email')),
                ),
                const SizedBox(height: 10),
                _contactRow(
                  icon: Icons.public,
                  label: 'Kişisel İnternet Sitesi',
                  value: _website,
                  trailing: Icons.open_in_new,
                  onTap: () => launchUrl(
                    Uri.parse('https://$_website'),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                const SizedBox(height: 28),
                Text('Detaylar', style: AppTextStyles.bodyBold),
                const SizedBox(height: 12),
                _hubTile(
                  context,
                  icon: Icons.format_quote,
                  title: 'Başkanın Mesajı',
                  subtitle: 'Hemşehrilerine seslenişi',
                  page: const MayorMessagePage(),
                  color: AppColors.primary,
                ),
                _hubTile(
                  context,
                  icon: Icons.school,
                  title: 'Özgeçmiş',
                  subtitle: 'Eğitim ve kariyer geçmişi',
                  page: const MayorBiographyPage(),
                  color: AppColors.primary,
                ),
                _hubTile(
                  context,
                  icon: Icons.photo_library,
                  title: 'Başkanın Fotoğrafları',
                  subtitle: 'Görev başında çekilmiş albüm',
                  page: const MayorPhotosPage(),
                  color: AppColors.accent,
                ),
                _hubTile(
                  context,
                  icon: Icons.diversity_3,
                  title: 'Başkan ve Vatandaş',
                  subtitle: 'Vatandaş ile bir araya geldiği anlar',
                  page: const MayorPhotosPage(citizenView: true),
                  color: AppColors.accent,
                ),
                _hubTile(
                  context,
                  icon: Icons.send,
                  title: 'Başkana Mesaj Gönder',
                  subtitle: 'Talep, öneri, teşekkür ve şikayetleriniz',
                  page: const MayorContactPage(),
                  color: AppColors.success,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      height: 280,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.18,
              child: Image.network(
                'https://picsum.photos/seed/cekmekoy_skyline/1200/600',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
          Image.asset(
            AppStrings.mayorPhoto,
            height: 260,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _socialRow() {
    return Row(
      children: [
        _socialBtn(Icons.camera_alt, _instagram),
        const SizedBox(width: 10),
        _socialBtn(Icons.alternate_email, _twitter),
        const SizedBox(width: 10),
        _socialBtn(Icons.facebook, _facebook),
        const SizedBox(width: 10),
        _socialBtn(Icons.smart_display, _youtube),
      ],
    );
  }

  Widget _socialBtn(IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 22, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _contactRow({
    required IconData icon,
    required String label,
    required String value,
    IconData? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.caption),
                  const SizedBox(height: 2),
                  Text(value,
                      style: AppTextStyles.bodyBold.copyWith(color: AppColors.primary)),
                ],
              ),
            ),
            if (trailing != null) Icon(trailing, color: AppColors.textTertiary, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _hubTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => page)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.bodyBold),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

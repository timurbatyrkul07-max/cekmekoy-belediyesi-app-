import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../mayor/pages/mayor_photos_page.dart';

class PressPage extends StatelessWidget {
  const PressPage({super.key});

  static const _site = 'https://cekmekoy.bel.tr';

  static const _logoFile =
      '$_site/upload/files/cekmekoy-belediyesi-logosu-vektorel-7d6cb158-5fdc-4006-b067-8b65539a4009.rar';

  static const _mayorPhotos = [
    '$_site/upload/files/baskan-foto-082b7337-4e8e-4864-9863-e1d4fcbd954c.jpg',
    '$_site/upload/files/baskan-foto-7e021622-3d5c-4c4b-bb43-c44eff26a0ff.jpg',
    '$_site/upload/files/baskan-foto-9b009a77-654b-4d03-b9dd-b87075324f12.jpg',
    '$_site/upload/files/baskan-foto-a06ca876-2133-4d70-8dc2-c6004f9c62cf.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Basın İçin',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          _hero(),
          const SizedBox(height: 24),
          _SectionHeader(
            icon: Icons.workspace_premium,
            title: 'Çekmeköy Kurumsal Kimlik',
          ),
          const SizedBox(height: 12),
          _LogoCard(downloadUrl: _logoFile),
          const SizedBox(height: 28),
          _SectionHeader(
            icon: Icons.person,
            title: 'Çekmeköy Belediye Başkanının Görselleri',
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _mayorPhotos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (_, i) => _PhotoCard(
              url: _mayorPhotos[i],
              index: i + 1,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PhotoViewerPage(
                    images: _mayorPhotos,
                    initialIndex: i,
                  ),
                  fullscreenDialog: true,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          _SectionHeader(
            icon: Icons.contact_mail,
            title: 'Basın İletişim',
          ),
          const SizedBox(height: 12),
          _ContactRow(
            icon: Icons.business_center,
            label: 'Birim',
            value: 'Basın, Yayın ve Halkla İlişkiler Müdürlüğü',
          ),
          const SizedBox(height: 8),
          _ContactRow(
            icon: Icons.phone,
            label: 'Telefon',
            value: '+90 (216) 600 0600',
            onTap: () => launchUrl(Uri.parse('tel:+902166000600')),
          ),
          const SizedBox(height: 8),
          _ContactRow(
            icon: Icons.mail_outline,
            label: 'E-posta',
            value: 'basin@cekmekoy.bel.tr',
            onTap: () => launchUrl(Uri.parse('mailto:basin@cekmekoy.bel.tr')),
          ),
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.newspaper, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BASIN MENSUPLARI İÇİN',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white70,
                      fontSize: 10,
                      letterSpacing: 1,
                    )),
                const SizedBox(height: 2),
                Text('Kurumsal Kimlik\nve Görseller',
                    style: AppTextStyles.h3.copyWith(color: Colors.white, height: 1.2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(title,
              style: AppTextStyles.bodyBold.copyWith(fontSize: 15)),
        ),
      ],
    );
  }
}

class _LogoCard extends StatelessWidget {
  final String downloadUrl;
  const _LogoCard({required this.downloadUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ClipOval(
                    child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Çekmeköy Belediyesi Logosu',
                        style: AppTextStyles.bodyBold),
                    const SizedBox(height: 2),
                    Text('Vektörel format (.rar)',
                        style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => launchUrl(
                Uri.parse(downloadUrl),
                mode: LaunchMode.externalApplication,
              ),
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Logo Paketini İndir'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final String url;
  final int index;
  final VoidCallback onTap;

  const _PhotoCard({
    required this.url,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (_, __) => Container(color: AppColors.background),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.background,
                    child: const Icon(Icons.broken_image,
                        color: AppColors.textTertiary),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Görsel $index',
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  GestureDetector(
                    onTap: () => launchUrl(
                      Uri.parse(url),
                      mode: LaunchMode.externalApplication,
                    ),
                    child: const Icon(Icons.download,
                        color: AppColors.primary, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                          color: onTap != null
                              ? AppColors.primary
                              : AppColors.textPrimary,
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

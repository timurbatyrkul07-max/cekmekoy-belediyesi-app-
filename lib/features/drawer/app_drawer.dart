import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_strings.dart';
import '../../core/router/router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/data/menu_data.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int? _expandedGroup;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMayorCard(),
                  const SizedBox(height: 12),
                  _buildTopButtons(),
                  const SizedBox(height: 20),
                  _sectionLabel(AppStrings.eMunicipality),
                  ...List.generate(MenuData.eMunicipality.length, (i) {
                    return _eMunicipalityGroup(i, MenuData.eMunicipality[i]);
                  }),
                  const SizedBox(height: 20),
                  _sectionLabel(AppStrings.municipality),
                  ...MenuData.municipality.map(_menuTile),
                  const SizedBox(height: 20),
                  _sectionLabel(AppStrings.corporate),
                  ...MenuData.corporate.map(_menuTile),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  Builder(
                    builder: (context) => ListTile(
                      leading: const Icon(Icons.settings, color: AppColors.primary),
                      title: Text('Ayarlar', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        AppRouter.open(context, '/settings');
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                  const Divider(height: 1),
                  _buildSupportLine(),
                  const SizedBox(height: 8),
                  _buildSocial(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
          const Spacer(),
          Image.asset('assets/images/logo.png', height: 44),
        ],
      ),
    );
  }

  Widget _buildMayorCard() {
    return Builder(
      builder: (context) => InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).pop();
          AppRouter.open(context, '/mayor');
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              AppStrings.mayorPhoto,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.mayorName,
                  style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  AppStrings.mayorTitle,
                  style: AppTextStyles.caption.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white),
        ],
      ),
        ),
      ),
    );
  }

  Widget _buildTopButtons() {
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(child: _topBtn(context, Icons.event_note, 'Etkinlikler', '/events')),
            const SizedBox(width: 12),
            Expanded(child: _topBtn(context, Icons.newspaper, 'Haberler', '/news')),
          ],
        ),
      ),
    );
  }

  Widget _topBtn(BuildContext context, IconData icon, String label, String route) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).pop();
        AppRouter.open(context, route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: AppColors.textPrimary),
            const SizedBox(width: 8),
            Text(label, style: AppTextStyles.bodyBold),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 16, 8),
      child: Text(title, style: AppTextStyles.sectionLabel),
    );
  }

  Widget _eMunicipalityGroup(int index, MenuGroup group) {
    final isOpen = _expandedGroup == index;
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _expandedGroup = isOpen ? null : index;
            });
          },
          child: Container(
            color: isOpen ? AppColors.surface : Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Icon(group.icon, color: AppColors.primary, size: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(group.title, style: AppTextStyles.bodyBold),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
        ),
        if (isOpen)
          Container(
            color: AppColors.surface.withValues(alpha: 0.5),
            child: Column(
              children: group.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListTile(
                    title: Text(item.label, style: AppTextStyles.body),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 20),
                    onTap: () {
                      Navigator.of(context).pop();
                      AppRouter.open(context, item.route);
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    dense: true,
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _menuTile(MenuItem item) {
    return Builder(
      builder: (context) => ListTile(
        leading: Icon(item.icon, color: AppColors.primary, size: 22),
        title: Text(item.label, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 20),
        onTap: () {
          Navigator.of(context).pop();
          AppRouter.open(context, item.route);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        dense: true,
      ),
    );
  }

  Widget _buildSupportLine() {
    return ListTile(
      leading: const Icon(Icons.phone, color: AppColors.primary),
      title: Text(AppStrings.supportLineLabel, style: AppTextStyles.body),
      subtitle: Text(
        AppStrings.supportLine,
        style: AppTextStyles.h3.copyWith(color: AppColors.primary),
      ),
      onTap: () => launchUrl(Uri.parse('tel:${AppStrings.supportLineDial}')),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  Widget _buildSocial() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.socialMediaTitle, style: AppTextStyles.caption),
          const SizedBox(height: 12),
          Row(
            children: [
              _socialBtn(Icons.camera_alt, 'https://www.instagram.com/cekmekoybelediyesi'),
              const SizedBox(width: 10),
              _socialBtn(Icons.alternate_email, 'https://twitter.com/cekmekoybeltr'),
              const SizedBox(width: 10),
              _socialBtn(Icons.facebook, 'https://www.facebook.com/cekmekoybelediyesi'),
              const SizedBox(width: 10),
              _socialBtn(Icons.smart_display, 'https://www.youtube.com/cekmekoybelediyesi'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialBtn(IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: AppColors.textPrimary),
      ),
    );
  }
}

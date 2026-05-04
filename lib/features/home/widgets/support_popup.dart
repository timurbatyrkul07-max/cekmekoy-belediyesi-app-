import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SupportPopup extends StatelessWidget {
  const SupportPopup({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (_) => const SupportPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom + 100,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SupportButton(
                    icon: Icons.chat,
                    label: 'WhatsApp',
                    color: const Color(0xFF25D366),
                    onTap: () {
                      Navigator.pop(context);
                      launchUrl(
                        Uri.parse('https://wa.me/${AppStrings.supportWhatsapp.replaceAll('+', '')}'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                  ),
                  const Divider(height: 1),
                  _SupportButton(
                    icon: Icons.phone,
                    label: 'Bizi Arayın',
                    color: AppColors.primary,
                    onTap: () {
                      Navigator.pop(context);
                      launchUrl(Uri.parse('tel:${AppStrings.supportLineDial}'));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SupportButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SupportButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(
              label,
              style: AppTextStyles.bodyBold,
            ),
            const Spacer(),
            Icon(icon, color: color, size: 26),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'support_popup.dart';
import '../../request/pages/request_page.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      color: AppColors.background,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80 + bottomPadding),
            painter: _NotchedBarPainter(),
            child: Padding(
              padding: EdgeInsets.only(
                top: 14,
                bottom: bottomPadding + 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.send_rounded,
                      label: AppStrings.sendRequest,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const RequestPage()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 80),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.support_agent_rounded,
                      label: AppStrings.supportLineLabel,
                      onTap: () => SupportPopup.show(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -34,
            child: _FloatingLogo(),
          ),
        ],
      ),
    );
  }
}

class _NotchedBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.primary, AppColors.primaryLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 12);

    final path = Path();
    const notchRadius = 38.0;
    final centerX = size.width / 2;

    // Sol köşeden başla
    path.moveTo(0, 0);
    // Notch'a kadar git
    path.lineTo(centerX - notchRadius - 8, 0);
    // Yumuşak giriş kavisi
    path.quadraticBezierTo(
      centerX - notchRadius, 0,
      centerX - notchRadius + 4, 6,
    );
    // Notch yarım daire (yukarı eğilmiş)
    path.arcToPoint(
      Offset(centerX + notchRadius - 4, 6),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    // Yumuşak çıkış kavisi
    path.quadraticBezierTo(
      centerX + notchRadius, 0,
      centerX + notchRadius + 8, 0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FloatingLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ClipOval(
          child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionButton({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

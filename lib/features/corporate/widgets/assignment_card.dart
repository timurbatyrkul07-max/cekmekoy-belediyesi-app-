import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../organization/data/organization_api.dart';

class AssignmentCard extends StatelessWidget {
  final OrganizationAssignment assignment;
  final bool detailed;

  const AssignmentCard({
    super.key,
    required this.assignment,
    this.detailed = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasContact = (assignment.phone?.isNotEmpty ?? false) ||
        (assignment.email?.isNotEmpty ?? false);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _avatar(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(assignment.fullName, style: AppTextStyles.bodyBold),
                    const SizedBox(height: 2),
                    Text(assignment.title,
                        style: AppTextStyles.caption
                            .copyWith(color: AppColors.textSecondary)),
                    if (assignment.organizationUnitName.isNotEmpty &&
                        assignment.organizationUnitName != assignment.title) ...[
                      const SizedBox(height: 4),
                      Text(
                        assignment.organizationUnitName,
                        style: AppTextStyles.caption
                            .copyWith(color: AppColors.textTertiary, fontSize: 11),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (detailed && hasContact) ...[
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),
            if (assignment.phone?.isNotEmpty ?? false)
              _row(
                Icons.phone,
                assignment.phone!,
                onTap: () => launchUrl(Uri.parse(
                    'tel:${assignment.phone!.replaceAll(RegExp(r"[^0-9+]"), "")}')),
              ),
            if (assignment.email?.isNotEmpty ?? false) ...[
              if (assignment.phone?.isNotEmpty ?? false) const SizedBox(height: 6),
              _row(
                Icons.mail_outline,
                assignment.email!,
                onTap: () => launchUrl(Uri.parse('mailto:${assignment.email}')),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _avatar() {
    final hasPhoto = assignment.profileFilePath != null &&
        assignment.profileFilePath!.isNotEmpty;
    if (hasPhoto) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: assignment.profileUrl,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          placeholder: (_, __) => _initialsAvatar(),
          errorWidget: (_, __, ___) => _initialsAvatar(),
        ),
      );
    }
    return _initialsAvatar();
  }

  Widget _initialsAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _initials(assignment.fullName),
          style: AppTextStyles.bodyBold.copyWith(
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _row(IconData icon, String text, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return '${parts[0][0]}${parts.last[0]}'.toUpperCase();
  }
}

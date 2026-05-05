import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../corporate/widgets/assignment_card.dart';
import '../../organization/data/organization_api.dart';
import '../data/department_defaults.dart';

class DepartmentUnitDetailPage extends ConsumerWidget {
  final OrganizationUnit unit;
  const DepartmentUnitDetailPage({super.key, required this.unit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAssignments = ref.watch(unitAssignmentsProvider(unit.id));

    final phoneFromApi = unit.phone;
    final emailFromApi = unit.email;
    final addressFromApi = unit.address;
    final phoneText =
        (phoneFromApi != null && phoneFromApi.isNotEmpty) ? phoneFromApi : DepartmentDefaults.phoneFor(unit.name);
    final emailText =
        (emailFromApi != null && emailFromApi.isNotEmpty) ? emailFromApi : DepartmentDefaults.guessEmail(unit.name);
    final addressText = (addressFromApi != null && addressFromApi.isNotEmpty)
        ? addressFromApi
        : 'Çekmeköy Belediyesi, Merkez Mh. Piri Reis Cd. No:5 Çekmeköy/İstanbul';
    final aboutText = (unit.summary != null && unit.summary!.isNotEmpty)
        ? unit.summary!
        : DepartmentDefaults.aboutFor(unit.name);
    final services = DepartmentDefaults.servicesFor(unit.name);

    return BrandedScaffold(
      title: unit.name,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _hero(),
          if (unit.parentUnitName != null && unit.parentUnitName!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _parentBadge(),
          ],
          const SizedBox(height: 20),
          _section('Hakkında', child: Text(aboutText, style: _bodyStyle())),
          const SizedBox(height: 20),
          _managerSection(asyncAssignments),
          const SizedBox(height: 20),
          _section(
            'Görev ve Hizmetler',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: services
                  .map((s) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.only(top: 8),
                              decoration: const BoxDecoration(
                                color: AppColors.accent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(s,
                                  style: AppTextStyles.body.copyWith(height: 1.5)),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          _section(
            'İletişim',
            child: Column(
              children: [
                _contactRow(
                  icon: Icons.phone,
                  label: 'Telefon',
                  value: phoneText,
                  highlight: phoneFromApi == null || phoneFromApi.isEmpty,
                  onTap: () => launchUrl(Uri.parse('tel:+902166000600')),
                ),
                const SizedBox(height: 8),
                _contactRow(
                  icon: Icons.mail_outline,
                  label: 'E-posta',
                  value: emailText,
                  highlight: emailFromApi == null || emailFromApi.isEmpty,
                  onTap: () => launchUrl(Uri.parse('mailto:$emailText')),
                ),
                const SizedBox(height: 8),
                _contactRow(
                  icon: Icons.location_on,
                  label: 'Adres',
                  value: addressText,
                  highlight: addressFromApi == null || addressFromApi.isEmpty,
                ),
              ],
            ),
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
            child: const Icon(Icons.business_center, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MÜDÜRLÜK',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white70,
                      letterSpacing: 1,
                      fontSize: 10,
                    )),
                const SizedBox(height: 2),
                Text(unit.name,
                    style: AppTextStyles.h3.copyWith(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _parentBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_tree, size: 14, color: AppColors.accent),
          const SizedBox(width: 6),
          Text(
            'Bağlı: ',
            style: AppTextStyles.caption,
          ),
          Expanded(
            child: Text(
              unit.parentUnitName!,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _managerSection(AsyncValue<List<OrganizationAssignment>> asyncAssignments) {
    return _section(
      'Yetkili',
      child: asyncAssignments.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Text('Yüklenemedi.',
            style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
        data: (list) {
          final filtered = list
              .where((a) => !a.fullName.toLowerCase().contains('test'))
              .toList();
          if (filtered.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.textTertiary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Yetkili bilgisi henüz girilmemiş.',
                        style: AppTextStyles.caption),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: filtered
                .map((a) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AssignmentCard(assignment: a),
                    ))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _section(String title, {required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: AppTextStyles.sectionLabel),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _contactRow({
    required IconData icon,
    required String label,
    required String value,
    bool highlight = false,
    VoidCallback? onTap,
  }) {
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
                    Row(
                      children: [
                        Text(label, style: AppTextStyles.caption),
                        if (highlight) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              'tahmini',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.accent,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      value,
                      style: AppTextStyles.bodyBold.copyWith(
                        color: onTap != null ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _bodyStyle() => AppTextStyles.body.copyWith(
        height: 1.6,
        fontSize: 14,
        color: AppColors.textSecondary,
      );
}

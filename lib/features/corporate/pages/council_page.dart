import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../organization/data/organization_api.dart';
import '../widgets/assignment_card.dart';

class CouncilPage extends ConsumerWidget {
  const CouncilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(councilProvider);
    return BrandedScaffold(
      title: 'Belediye Meclisi',
      child: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Meclis bilgileri yüklenemedi.\n$e',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
          ),
        ),
        data: (data) {
          final list = data.assignments
              .where((a) => !a.fullName.toLowerCase().contains('test'))
              .toList();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance,
                        color: AppColors.primary, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.unit?.name ?? 'Belediye Meclisi',
                              style: AppTextStyles.bodyBold),
                          if (list.isNotEmpty)
                            Text('${list.length} üye',
                                style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (list.isEmpty)
                _empty()
              else
                ...list.map((a) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AssignmentCard(assignment: a, detailed: false),
                    )),
            ],
          );
        },
      ),
    );
  }

  Widget _empty() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            const Icon(Icons.info_outline, size: 56, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text('Meclis üyeleri henüz girilmemiş',
                style: AppTextStyles.bodyBold),
          ],
        ),
      );
}

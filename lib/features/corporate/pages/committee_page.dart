import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../organization/data/organization_api.dart';
import '../widgets/assignment_card.dart';

class CommitteePage extends ConsumerWidget {
  const CommitteePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(committeeProvider);
    return BrandedScaffold(
      title: 'Belediye Encümeni',
      child: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Encümen bilgileri yüklenemedi.\n$e',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.gavel, color: AppColors.primary, size: 18),
                        const SizedBox(width: 8),
                        Text('Encümen Hakkında', style: AppTextStyles.bodyBold),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Belediye Encümeni, Belediye Başkanı\'nın başkanlığında, belediye meclisi ve belediye birimlerinden seçilen üyelerden oluşur.',
                      style: AppTextStyles.body.copyWith(height: 1.5, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (list.isEmpty)
                _empty()
              else ...[
                Text('${list.length} Üye', style: AppTextStyles.bodyBold),
                const SizedBox(height: 12),
                ...list.map((a) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AssignmentCard(assignment: a, detailed: false),
                    )),
              ],
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
            Text('Encümen üyeleri henüz girilmemiş',
                style: AppTextStyles.bodyBold),
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../organization/data/organization_api.dart';
import '../widgets/assignment_card.dart';

class DeputyMayorsPage extends ConsumerWidget {
  const DeputyMayorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDeputies = ref.watch(deputyMayorsProvider);
    return BrandedScaffold(
      title: 'Başkan Yardımcıları',
      child: asyncDeputies.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Başkan yardımcıları yüklenemedi.\n$e',
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ),
        data: (list) {
          if (list.isEmpty) {
            return _empty();
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('${list.length} kişi', style: AppTextStyles.sectionLabel),
              const SizedBox(height: 12),
              ...list.map((a) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AssignmentCard(assignment: a),
                  )),
            ],
          );
        },
      ),
    );
  }

  Widget _empty() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text('Başkan Yardımcısı bilgisi henüz girilmemiş',
                style: AppTextStyles.bodyBold),
          ],
        ),
      );
}

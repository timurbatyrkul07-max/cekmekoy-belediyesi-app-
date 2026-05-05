import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../data/corporate_data.dart';

class RegulationsPage extends StatelessWidget {
  const RegulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<Regulation>>{};
    for (final r in CorporateData.regulations) {
      groups.putIfAbsent(r.type, () => []).add(r);
    }
    return BrandedScaffold(
      title: 'Mevzuat',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: groups.entries.expand((e) => [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
                child: Text(e.key.toUpperCase(), style: AppTextStyles.sectionLabel),
              ),
              ...e.value.map((r) => _RegulationTile(item: r)),
            ]).toList(),
      ),
    );
  }
}

class _RegulationTile extends StatelessWidget {
  final Regulation item;
  const _RegulationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.description, color: AppColors.primary, size: 20),
          ),
          title: Text(item.title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
          subtitle: item.year != null
              ? Text(item.year!, style: AppTextStyles.caption)
              : null,
          trailing: const Icon(Icons.open_in_new, color: AppColors.textTertiary, size: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onTap: () {},
        ),
      ),
    );
  }
}

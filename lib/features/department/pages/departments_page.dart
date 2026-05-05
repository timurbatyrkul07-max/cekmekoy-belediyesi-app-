import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../organization/data/organization_api.dart';
import 'department_unit_detail_page.dart';

class DepartmentsPage extends ConsumerStatefulWidget {
  const DepartmentsPage({super.key});

  @override
  ConsumerState<DepartmentsPage> createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends ConsumerState<DepartmentsPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(departmentsProvider);
    return BrandedScaffold(
      title: 'Müdürlükler',
      child: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Müdürlükler yüklenemedi.\n$e',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
          ),
        ),
        data: (units) {
          final filtered = _query.isEmpty
              ? units
              : units
                  .where((u) => u.name.toLowerCase().contains(_query.toLowerCase()))
                  .toList();
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            children: [
              TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Müdürlüklerde arama yapın',
                  hintStyle:
                      AppTextStyles.body.copyWith(color: AppColors.textTertiary),
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.textTertiary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                ),
              ),
              const SizedBox(height: 12),
              Text('${filtered.length} müdürlük', style: AppTextStyles.sectionLabel),
              const SizedBox(height: 8),
              ...filtered.map((u) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _DepartmentTile(unit: u),
                  )),
            ],
          );
        },
      ),
    );
  }
}

class _DepartmentTile extends StatelessWidget {
  final OrganizationUnit unit;
  const _DepartmentTile({required this.unit});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DepartmentUnitDetailPage(unit: unit)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.business_center,
                    color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(unit.name,
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}

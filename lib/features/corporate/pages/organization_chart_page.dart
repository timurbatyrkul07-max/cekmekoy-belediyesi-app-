import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../department/pages/department_unit_detail_page.dart';
import '../../organization/data/organization_api.dart';

class OrganizationChartPage extends ConsumerWidget {
  const OrganizationChartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUnits = ref.watch(_unitsProvider);
    return BrandedScaffold(
      title: 'Organizasyon Şeması',
      child: asyncUnits.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Yüklenemedi.\n$e',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
          ),
        ),
        data: (units) => _ChartView(units: units),
      ),
    );
  }
}

final _unitsProvider = FutureProvider<List<OrganizationUnit>>((ref) async {
  return ref.read(organizationRepositoryProvider).fetchUnits();
});

class _ChartView extends StatelessWidget {
  final List<OrganizationUnit> units;
  const _ChartView({required this.units});

  @override
  Widget build(BuildContext context) {
    final presidency = units.firstWhere(
      (u) => u.isPresidency,
      orElse: () => OrganizationUnit(id: 0, name: 'Belediye Başkanlığı', organizationUnitType: 1),
    );
    final deputyMayors = units.where((u) => u.isDeputyMayor).toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    final councilUnits = units.where((u) => u.isCouncil).toList();
    final committeeUnits = units.where((u) => u.isCommittee).toList();
    final directDeps = units
        .where((u) =>
            u.isDepartment &&
            u.parentUnitId == presidency.id)
        .toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        _PresidentNode(name: 'Orhan ÇERKEZ', subtitle: 'Belediye Başkanı'),
        const _Connector(),
        _SectionHeader(title: 'BAŞKAN YARDIMCILARI', count: deputyMayors.length),
        const SizedBox(height: 8),
        ...deputyMayors.map((dm) {
          final children = units
              .where((u) => u.isDepartment && u.parentUnitId == dm.id)
              .toList()
            ..sort((a, b) => a.id.compareTo(b.id));
          return _DeputyNode(unit: dm, children: children);
        }),
        if (directDeps.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionHeader(
            title: 'BAŞKANLIĞA BAĞLI MÜDÜRLÜKLER',
            count: directDeps.length,
          ),
          const SizedBox(height: 8),
          ...directDeps.map((d) => _LeafNode(name: d.name, color: AppColors.textSecondary)),
        ],
        if (councilUnits.isNotEmpty || committeeUnits.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 12),
          _SectionHeader(title: 'BELEDİYE BİRİMLERİ'),
          const SizedBox(height: 8),
          ...councilUnits.map((u) => _LeafNode(name: u.name, color: AppColors.accent, icon: Icons.account_balance)),
          ...committeeUnits.map((u) => _LeafNode(name: u.name, color: AppColors.accent, icon: Icons.gavel)),
        ],
      ],
    );
  }
}

class _PresidentNode extends StatelessWidget {
  final String name;
  final String subtitle;
  const _PresidentNode({required this.name, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(subtitle.toUpperCase(),
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white70,
                  fontSize: 10,
                  letterSpacing: 1,
                )),
            const SizedBox(height: 2),
            Text(name,
                style: AppTextStyles.h2.copyWith(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class _DeputyNode extends StatefulWidget {
  final OrganizationUnit unit;
  final List<OrganizationUnit> children;
  const _DeputyNode({required this.unit, required this.children});

  @override
  State<_DeputyNode> createState() => _DeputyNodeState();
}

class _DeputyNodeState extends State<_DeputyNode> {
  bool _open = true;

  String _personName(OrganizationUnit u) {
    final extracted = u.extractedPersonName;
    return extracted ?? u.name.replaceAll('Başkan Yardımcılığı', '').trim();
  }

  @override
  Widget build(BuildContext context) {
    final name = _personName(widget.unit);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() => _open = !_open),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _initials(name),
                        style: AppTextStyles.bodyBold.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: AppTextStyles.bodyBold.copyWith(fontSize: 14)),
                        Text('Başkan Yardımcısı',
                            style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${widget.children.length}',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _open ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
          if (_open && widget.children.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 4),
              child: Column(
                children: widget.children
                    .map((c) => _ChildBranch(unit: c))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return '${parts[0][0]}${parts.last[0]}'.toUpperCase();
  }
}

class _ChildBranch extends StatelessWidget {
  final OrganizationUnit unit;
  const _ChildBranch({required this.unit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 2, color: AppColors.divider),
            Container(
              width: 16,
              alignment: Alignment.center,
              child: Container(height: 2, color: AppColors.divider),
            ),
            Expanded(
              child: Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DepartmentUnitDetailPage(unit: unit),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(unit.name,
                              style: AppTextStyles.body.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        const Icon(Icons.chevron_right,
                            color: AppColors.textTertiary, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeafNode extends StatelessWidget {
  final String name;
  final Color color;
  final IconData? icon;
  const _LeafNode({required this.name, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border(left: BorderSide(color: color, width: 3)),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 8),
            ] else ...[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
            ],
            Text(name, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int? count;
  const _SectionHeader({required this.title, this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.sectionLabel),
        if (count != null) ...[
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$count',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.accent,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Connector extends StatelessWidget {
  const _Connector();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 2,
        height: 22,
        color: AppColors.divider,
        margin: const EdgeInsets.symmetric(vertical: 6),
      ),
    );
  }
}

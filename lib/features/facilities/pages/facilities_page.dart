import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../data/facilities_api.dart';
import 'facility_detail_page.dart';

class FacilitiesPage extends ConsumerStatefulWidget {
  const FacilitiesPage({super.key});

  @override
  ConsumerState<FacilitiesPage> createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends ConsumerState<FacilitiesPage> {
  int? _selectedCategoryId;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final asyncCats = ref.watch(facilityCategoriesProvider);
    final asyncList = ref.watch(facilitiesListProvider);

    return BrandedScaffold(
      title: 'Sosyal Tesisler',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Tesislerde arama yapın',
                hintStyle: AppTextStyles.body.copyWith(color: AppColors.textTertiary),
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
          ),
          asyncCats.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (cats) {
              if (cats.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _filterChip(
                      label: 'Tümü',
                      selected: _selectedCategoryId == null,
                      onTap: () => setState(() => _selectedCategoryId = null),
                    ),
                    ...cats.map((c) => _filterChip(
                          label: c.name,
                          selected: _selectedCategoryId == c.id,
                          onTap: () =>
                              setState(() => _selectedCategoryId = c.id),
                        )),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: asyncList.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Tesisler yüklenemedi.\n$e',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body
                          .copyWith(color: AppColors.textSecondary)),
                ),
              ),
              data: (items) {
                final filtered = items.where((f) {
                  if (_selectedCategoryId != null && f.type != _selectedCategoryId) {
                    return false;
                  }
                  if (_query.isEmpty) return true;
                  return f.name.toLowerCase().contains(_query.toLowerCase());
                }).toList();
                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.business,
                            size: 64, color: AppColors.textTertiary),
                        const SizedBox(height: 12),
                        Text('Henüz tesis eklenmemiş',
                            style: AppTextStyles.bodyBold),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _FacilityCard(item: filtered[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: selected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _FacilityCard extends StatelessWidget {
  final FacilityItem item;
  const _FacilityCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => FacilityDetailPage(item: item)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: item.coverFilePath != null && item.coverFilePath!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: item.coverUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(color: AppColors.background),
                        errorWidget: (_, __, ___) => _placeholder(),
                      )
                    : _placeholder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.typeName != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.typeName!.toUpperCase(),
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.accent,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  const SizedBox(height: 6),
                  Text(item.name, style: AppTextStyles.bodyBold),
                  if (item.address != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 12, color: AppColors.textTertiary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(item.address!,
                              style: AppTextStyles.caption,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.primary.withValues(alpha: 0.08),
      alignment: Alignment.center,
      child: const Icon(Icons.business, size: 40, color: AppColors.primary),
    );
  }
}

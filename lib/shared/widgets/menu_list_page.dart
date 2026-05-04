import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'branded_scaffold.dart';

class MenuListItem {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const MenuListItem({required this.label, required this.icon, this.onTap});
}

class MenuListPage extends StatefulWidget {
  final String title;
  final List<MenuListItem> items;
  final bool searchable;

  const MenuListPage({
    super.key,
    required this.title,
    required this.items,
    this.searchable = false,
  });

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _query.isEmpty
        ? widget.items
        : widget.items
            .where((it) => it.label.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    return BrandedScaffold(
      title: widget.title,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          if (widget.searchable)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: '${widget.title} içinde arama yapın',
                  hintStyle: AppTextStyles.body.copyWith(color: AppColors.textTertiary),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textTertiary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                ),
              ),
            ),
          ...filtered.map(_buildItem),
        ],
      ),
    );
  }

  Widget _buildItem(MenuListItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: item.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(item.icon, color: AppColors.primary, size: 22),
                const SizedBox(width: 14),
                Expanded(child: Text(item.label, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500))),
                const Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

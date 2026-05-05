import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../mayor/pages/mayor_photos_page.dart';
import '../data/galleries_api.dart';

class GalleryPage extends ConsumerWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGalleries = ref.watch(galleriesListProvider);
    return BrandedScaffold(
      title: 'Çekmeköy Albümü',
      child: asyncGalleries.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Albümler yüklenemedi.\n$e',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
          ),
        ),
        data: (galleries) {
          if (galleries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.photo_library, size: 64, color: AppColors.textTertiary),
                  const SizedBox(height: 12),
                  Text('Henüz albüm yok', style: AppTextStyles.bodyBold),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: galleries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (_, i) => _AlbumCard(album: galleries[i]),
          );
        },
      ),
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final GalleryApiItem album;
  const _AlbumCard({required this.album});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AlbumDetailPage(album: album)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: album.coverUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.surface),
                errorWidget: (_, __, ___) => Container(color: AppColors.surface),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(album.displayTitle, style: AppTextStyles.bodyBold),
                        if (album.publishStartAt != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 12, color: AppColors.textTertiary),
                              const SizedBox(width: 4),
                              Text(
                                DateFormat('d MMMM y', 'tr_TR')
                                    .format(album.publishStartAt!),
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.textTertiary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlbumDetailPage extends ConsumerWidget {
  final GalleryApiItem album;
  const AlbumDetailPage({super.key, required this.album});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BrandedScaffold(
      title: album.displayTitle,
      child: FutureBuilder<List<GalleryItem>>(
        future: ref.read(galleriesRepositoryProvider).fetchItems(album.id),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final urls = snap.data!.map((it) => it.imageUrl).toList();
          if (urls.isEmpty) {
            return Center(
              child: Text('Bu albümde henüz fotoğraf yok',
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: urls.length,
            itemBuilder: (_, i) => InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PhotoViewerPage(images: urls, initialIndex: i),
                  fullscreenDialog: true,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: urls[i],
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: AppColors.surface),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.surface,
                    child: const Icon(Icons.broken_image, color: AppColors.textTertiary),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

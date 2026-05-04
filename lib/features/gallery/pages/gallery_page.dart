import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';

class GalleryAlbum {
  final String id;
  final String title;
  final String date;
  final List<String> images;

  const GalleryAlbum({
    required this.id,
    required this.title,
    required this.date,
    required this.images,
  });
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  static final _albums = [
    GalleryAlbum(
      id: 'a1',
      title: '23 Nisan Çocuk Şenliği 2026',
      date: '23 Nisan 2026',
      images: List.generate(8, (i) => 'https://picsum.photos/seed/cocuk$i/600/400'),
    ),
    GalleryAlbum(
      id: 'a2',
      title: '1 Mayıs Kutlamaları',
      date: '1 Mayıs 2026',
      images: List.generate(6, (i) => 'https://picsum.photos/seed/mayis$i/600/400'),
    ),
    GalleryAlbum(
      id: 'a3',
      title: 'Çekmeköy Bahar Festivali',
      date: '15 Nisan 2026',
      images: List.generate(10, (i) => 'https://picsum.photos/seed/bahar$i/600/400'),
    ),
    GalleryAlbum(
      id: 'a4',
      title: 'Kent Lokantası Açılışı',
      date: '3 Mayıs 2026',
      images: List.generate(5, (i) => 'https://picsum.photos/seed/lokanta$i/600/400'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Çekmeköy Albümü',
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _albums.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, i) => _AlbumCard(album: _albums[i]),
      ),
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final GalleryAlbum album;
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
                imageUrl: album.images.first,
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
                        Text(album.title, style: AppTextStyles.bodyBold),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.photo_library, size: 14, color: AppColors.textTertiary),
                            const SizedBox(width: 4),
                            Text('${album.images.length} fotoğraf',
                                style: AppTextStyles.caption),
                            const SizedBox(width: 12),
                            const Icon(Icons.calendar_today, size: 12, color: AppColors.textTertiary),
                            const SizedBox(width: 4),
                            Text(album.date, style: AppTextStyles.caption),
                          ],
                        ),
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

class AlbumDetailPage extends StatelessWidget {
  final GalleryAlbum album;
  const AlbumDetailPage({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: album.title,
      child: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
        ),
        itemCount: album.images.length,
        itemBuilder: (_, i) => InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => _PhotoViewerPage(images: album.images, initialIndex: i),
              fullscreenDialog: true,
            ),
          ),
          child: Hero(
            tag: 'photo-${album.id}-$i',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: album.images[i],
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.surface),
                errorWidget: (_, __, ___) => Container(color: AppColors.surface),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoViewerPage extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _PhotoViewerPage({required this.images, required this.initialIndex});

  @override
  State<_PhotoViewerPage> createState() => _PhotoViewerPageState();
}

class _PhotoViewerPageState extends State<_PhotoViewerPage> {
  late PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: _index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('${_index + 1} / ${widget.images.length}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.images.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (_, i) => InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: Center(
            child: CachedNetworkImage(
              imageUrl: widget.images[i],
              fit: BoxFit.contain,
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator(color: Colors.white)),
              errorWidget: (_, __, ___) => const Icon(Icons.error, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

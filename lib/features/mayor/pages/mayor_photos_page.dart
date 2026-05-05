import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../gallery/data/galleries_api.dart';

class MayorPhotosPage extends ConsumerWidget {
  final bool citizenView;
  const MayorPhotosPage({super.key, this.citizenView = false});

  static const _site = 'https://www.cekmekoy.bel.tr';

  static const _mockMayor = [
    '$_site/upload/pages/notchange/baskan_248.jpg',
    '$_site/upload/pages/notchange/cekmekoy-kent-lokantasi-hizmete-basladi-cc63d81e-86a6-402d-8fc5-e83375b4eb44.jpeg',
    '$_site/upload/pages/notchange/emekcilerle-omuz-omuza-1-mayis-kutlamasi-b36c5971-c072-455a-9dcb-6350ba1e18b7.jpeg',
    '$_site/upload/pages/notchange/cekmekoy-genclik-iklim-eylem-fonu-na-kabul-edildi-4ba4a7c8-b96c-498c-8b76-84e6e5d9e277.jpeg',
    '$_site/upload/pages/notchange/dev-dogal-yasam-alani-acildi-880-hayvana-guvenli-yuva-dffb3df1-1596-4561-9bf5-5e7e726f0b2b.jpeg',
    '$_site/upload/pages/notchange/cekmekoy-akademi-on-kayit-076b4245-a5ee-4f0f-86b2-1347c7c82c31.jpeg',
    '$_site/upload/pages/notchange/cekmekoy-akademi-ders-destek-atolyelerinde-on-kayitlar-basladi-29ecde57-0415-4b84-8237-7689890bb72f.jpeg',
    '$_site/upload/pages/notchange/cekmekoy-spor-okulu-kayit-basladi-625e3375-3bfb-4ba8-b655-e042d3bb8a1f.jpeg',
    '$_site/upload/pages/notchange/spor-okullari-yeni-donem-kayit-2026-84a51e6f-c0e6-4ebe-915b-9b4d27e4ef36.jpeg',
    '$_site/upload/pages/notchange/dask-2026-bcabe82e-07f0-4a2c-9503-7ac877396c5a.jpeg',
  ];

  static const _mockCitizen = [
    '$_site/upload/pages/notchange/cekmekoy-de-4-gun-surecek-cocuk-senligi-coskuyla-basladi-56557bee-29a2-475f-ab2c-89d363a521f8.jpeg',
    '$_site/upload/pages/notchange/cekmekoy-de-gokyuzu-cocuklarin-bayramina-sahne-oldu-035b4a2d-0c54-4fee-9ef0-782d14183375.jpeg',
    '$_site/upload/pages/notchange/miniklerden-23-nisan-coskusu-cekmekoy-de-kres-ogrencilerinden-renkli-gosteri-1c47d6a5-3921-4b55-a510-bcd6e544953d.jpeg',
    '$_site/upload/pages/notchange/emekcilerle-omuz-omuza-1-mayis-kutlamasi-b36c5971-c072-455a-9dcb-6350ba1e18b7.jpeg',
    '$_site/upload/pages/notchange/cekmekoy-kent-lokantasi-hizmete-basladi-cc63d81e-86a6-402d-8fc5-e83375b4eb44.jpeg',
    '$_site/upload/pages/notchange/dev-dogal-yasam-alani-acildi-880-hayvana-guvenli-yuva-dffb3df1-1596-4561-9bf5-5e7e726f0b2b.jpeg',
    '$_site/upload/pages/notchange/cekmekoy-akademi-on-kayit-076b4245-a5ee-4f0f-86b2-1347c7c82c31.jpeg',
    '$_site/upload/pages/notchange/cekmekoy-spor-okulu-kayit-basladi-625e3375-3bfb-4ba8-b655-e042d3bb8a1f.jpeg',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = citizenView ? 'Başkan ve Vatandaş' : 'Başkanın Fotoğrafları';
    final keyword = citizenView ? 'Vatandaş' : 'Başkan';
    final fallback = citizenView ? _mockCitizen : _mockMayor;
    final asyncPhotos = ref.watch(mayorPhotosProvider(keyword));

    return BrandedScaffold(
      title: title,
      child: asyncPhotos.when(
        loading: () => _grid(context, _placeholders()),
        error: (_, __) => _grid(context, fallback),
        data: (photos) => _grid(context, photos.isEmpty ? fallback : photos),
      ),
    );
  }

  List<String> _placeholders() => List.generate(9, (_) => '');

  Widget _grid(BuildContext context, List<String> photos) {
    if (photos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.photo_library, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text('Henüz fotoğraf yok', style: AppTextStyles.bodyBold),
          ],
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemCount: photos.length,
      itemBuilder: (_, i) {
        final url = photos[i];
        if (url.isEmpty) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
          );
        }
        return InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PhotoViewerPage(images: photos, initialIndex: i),
              fullscreenDialog: true,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.surface),
              errorWidget: (_, __, ___) => Container(
                color: AppColors.surface,
                child: const Icon(Icons.broken_image, color: AppColors.textTertiary),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PhotoViewerPage extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const PhotoViewerPage({super.key, required this.images, required this.initialIndex});

  @override
  State<PhotoViewerPage> createState() => _PhotoViewerPageState();
}

class _PhotoViewerPageState extends State<PhotoViewerPage> {
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

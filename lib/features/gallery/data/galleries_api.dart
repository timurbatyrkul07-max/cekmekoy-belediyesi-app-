import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../../../core/api/api_response.dart';

class GalleryCategory {
  final int id;
  final String name;
  final String urlPath;

  const GalleryCategory({required this.id, required this.name, required this.urlPath});

  factory GalleryCategory.fromJson(Map<String, dynamic> j) => GalleryCategory(
        id: j['id'] as int,
        name: j['name'] as String? ?? '',
        urlPath: j['urlPath'] as String? ?? '',
      );
}

class GalleryItem {
  final int id;
  final String? title;
  final String? filePath;
  final String? externalUrl;

  const GalleryItem({required this.id, this.title, this.filePath, this.externalUrl});

  factory GalleryItem.fromJson(Map<String, dynamic> j) => GalleryItem(
        id: j['id'] as int,
        title: j['title'] as String?,
        filePath: j['filePath'] as String?,
        externalUrl: j['externalUrl'] as String?,
      );

  String get imageUrl {
    if (filePath != null && filePath!.isNotEmpty) return ApiConfig.fullFileUrl(filePath);
    if (externalUrl != null && externalUrl!.isNotEmpty) return externalUrl!;
    return 'https://picsum.photos/seed/g$id/800/600';
  }
}

class GalleryApiItem {
  final int id;
  final String title;
  final int? categoryId;
  final String? coverFilePath;
  final DateTime? publishStartAt;
  final List<GalleryItem> items;

  const GalleryApiItem({
    required this.id,
    required this.title,
    this.categoryId,
    this.coverFilePath,
    this.publishStartAt,
    this.items = const [],
  });

  factory GalleryApiItem.fromJson(Map<String, dynamic> j) {
    final itemsRaw = j['items'];
    return GalleryApiItem(
      id: j['id'] as int,
      title: j['title'] as String? ?? '',
      categoryId: j['categoryId'] as int?,
      coverFilePath: j['coverFilePath'] as String?,
      publishStartAt: DateTime.tryParse(j['publishStartAt'] as String? ?? ''),
      items: itemsRaw is List
          ? itemsRaw
              .whereType<Map<String, dynamic>>()
              .map(GalleryItem.fromJson)
              .toList()
          : const [],
    );
  }

  String get coverUrl {
    if (coverFilePath != null && coverFilePath!.isNotEmpty) {
      return ApiConfig.fullFileUrl(coverFilePath);
    }
    if (items.isNotEmpty) return items.first.imageUrl;
    return 'https://picsum.photos/seed/cover$id/800/600';
  }

  String get displayTitle {
    if (title.isNotEmpty) return title;
    return 'Albüm #$id';
  }
}

class GalleriesRepository {
  final ApiClient _client;
  GalleriesRepository(this._client);

  Future<List<GalleryCategory>> fetchCategories() async {
    final raw = await _client.get('/api/public/galleries/categories');
    final dataRaw = raw['data'];
    if (dataRaw is List) {
      return dataRaw
          .whereType<Map<String, dynamic>>()
          .map(GalleryCategory.fromJson)
          .toList();
    }
    return [];
  }

  Future<List<GalleryApiItem>> fetchAll({int page = 1, int pageSize = 50}) async {
    final raw = await _client.get(
      '/api/public/galleries',
      query: {'page': page, 'pageSize': pageSize},
    );
    final res = ApiResponse.fromJson(
      raw,
      (d) =>
          Paginated.fromJson(d as Map<String, dynamic>, GalleryApiItem.fromJson),
    );
    return res.data?.results ?? [];
  }

  Future<GalleryApiItem?> fetchById(int id) async {
    final raw = await _client.get('/api/public/galleries/$id');
    final res = ApiResponse.fromJson(
      raw,
      (d) => GalleryApiItem.fromJson(d as Map<String, dynamic>),
    );
    return res.data;
  }

  Future<List<GalleryItem>> fetchItems(int galleryId) async {
    final raw = await _client.get('/api/public/galleries/items/by-gallery/$galleryId');
    final dataRaw = raw['data'];
    if (dataRaw is List) {
      return dataRaw
          .whereType<Map<String, dynamic>>()
          .map(GalleryItem.fromJson)
          .toList();
    }
    return [];
  }
}

final galleriesRepositoryProvider = Provider<GalleriesRepository>(
    (ref) => GalleriesRepository(ref.read(apiClientProvider)));

final galleryCategoriesProvider =
    FutureProvider<List<GalleryCategory>>((ref) async {
  return ref.read(galleriesRepositoryProvider).fetchCategories();
});

final galleriesListProvider =
    FutureProvider<List<GalleryApiItem>>((ref) async {
  return ref.read(galleriesRepositoryProvider).fetchAll();
});

/// Returns all photos from galleries whose category name contains [categoryNameContains].
/// If no match, falls back to all galleries.
final mayorPhotosProvider =
    FutureProvider.family<List<String>, String>((ref, categoryNameContains) async {
  final repo = ref.read(galleriesRepositoryProvider);
  final categories = await repo.fetchCategories();
  final matchingIds = categories
      .where((c) => c.name.toLowerCase().contains(categoryNameContains.toLowerCase()))
      .map((c) => c.id)
      .toSet();

  final all = await repo.fetchAll();
  final filtered = matchingIds.isEmpty
      ? all
      : all.where((g) => g.categoryId != null && matchingIds.contains(g.categoryId)).toList();

  final urls = <String>[];
  for (final g in filtered) {
    final items = await repo.fetchItems(g.id);
    for (final it in items) {
      final u = it.imageUrl;
      if (u.isNotEmpty) urls.add(u);
    }
  }
  return urls;
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../../../core/api/api_response.dart';

class PublicationCategory {
  final int id;
  final String name;
  final int count;
  final String? coverFilePath;

  const PublicationCategory({
    required this.id,
    required this.name,
    required this.count,
    this.coverFilePath,
  });

  factory PublicationCategory.fromJson(Map<String, dynamic> j) =>
      PublicationCategory(
        id: j['id'] as int,
        name: j['name'] as String? ?? '',
        count: j['count'] as int? ?? 0,
        coverFilePath: j['coverFilePath'] as String?,
      );

  String get coverUrl => ApiConfig.fullFileUrl(coverFilePath);
}

class PublicationItem {
  final int id;
  final String name;
  final String? urlPath;
  final String? coverFilePath;
  final int? type;
  final String? typeName;

  const PublicationItem({
    required this.id,
    required this.name,
    this.urlPath,
    this.coverFilePath,
    this.type,
    this.typeName,
  });

  factory PublicationItem.fromJson(Map<String, dynamic> j) => PublicationItem(
        id: j['id'] as int,
        name: j['name'] as String? ?? '',
        urlPath: j['urlPath'] as String?,
        coverFilePath: j['coverFilePath'] as String?,
        type: j['type'] as int?,
        typeName: j['typeName'] as String?,
      );

  String get coverUrl => ApiConfig.fullFileUrl(coverFilePath);

  String? get publicUrl =>
      urlPath != null ? 'https://www.cekmekoy.bel.tr/yayin/$urlPath' : null;
}

class PublicationsRepository {
  final ApiClient _client;
  PublicationsRepository(this._client);

  Future<List<PublicationCategory>> fetchCategories() async {
    final raw = await _client.get('/api/public/publications/categories');
    final dataRaw = raw['data'];
    if (dataRaw is List) {
      return dataRaw
          .whereType<Map<String, dynamic>>()
          .map(PublicationCategory.fromJson)
          .toList();
    }
    return [];
  }

  Future<List<PublicationItem>> fetchAll({int page = 1, int pageSize = 50}) async {
    final raw = await _client.get(
      '/api/public/publications',
      query: {'page': page, 'pageSize': pageSize},
    );
    final res = ApiResponse.fromJson(
      raw,
      (d) => Paginated.fromJson(
          d as Map<String, dynamic>, PublicationItem.fromJson),
    );
    return res.data?.results ?? [];
  }
}

final publicationsRepositoryProvider = Provider<PublicationsRepository>(
    (ref) => PublicationsRepository(ref.read(apiClientProvider)));

final publicationCategoriesProvider =
    FutureProvider<List<PublicationCategory>>((ref) async {
  return ref.read(publicationsRepositoryProvider).fetchCategories();
});

final publicationsListProvider =
    FutureProvider<List<PublicationItem>>((ref) async {
  return ref.read(publicationsRepositoryProvider).fetchAll();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../../../core/api/api_response.dart';

class LandmarkItem {
  final int id;
  final String name;
  final String? urlPath;
  final int type;
  final String? typeName;
  final String? description;
  final String? address;
  final int? constructionYear;
  final int? renovationYear;
  final double? totalArea;
  final double? latitude;
  final double? longitude;
  final String? coverFilePath;
  final int? neighborhoodId;
  final String? neighborhoodName;

  const LandmarkItem({
    required this.id,
    required this.name,
    this.urlPath,
    required this.type,
    this.typeName,
    this.description,
    this.address,
    this.constructionYear,
    this.renovationYear,
    this.totalArea,
    this.latitude,
    this.longitude,
    this.coverFilePath,
    this.neighborhoodId,
    this.neighborhoodName,
  });

  factory LandmarkItem.fromJson(Map<String, dynamic> j) => LandmarkItem(
        id: j['id'] as int,
        name: j['name'] as String? ?? '',
        urlPath: j['urlPath'] as String?,
        type: j['type'] as int? ?? 0,
        typeName: j['typeName'] as String?,
        description: j['description'] as String?,
        address: j['address'] as String?,
        constructionYear: j['constructionYear'] as int?,
        renovationYear: j['renovationYear'] as int?,
        totalArea: (j['totalArea'] as num?)?.toDouble(),
        latitude: (j['latitude'] as num?)?.toDouble(),
        longitude: (j['longitude'] as num?)?.toDouble(),
        coverFilePath: j['coverFilePath'] as String?,
        neighborhoodId: j['neighborhoodId'] as int?,
        neighborhoodName: j['neighborhoodName'] as String?,
      );

  String get coverUrl => ApiConfig.fullFileUrl(coverFilePath);
  bool get hasLocation => latitude != null && longitude != null;
}

class LandmarksRepository {
  final ApiClient _client;
  LandmarksRepository(this._client);

  Future<List<LandmarkItem>> fetchByType(int type, {int pageSize = 100}) async {
    final raw = await _client.get(
      '/api/public/landmarks',
      query: {'type': type, 'page': 1, 'pageSize': pageSize},
    );
    final res = ApiResponse.fromJson(
      raw,
      (d) =>
          Paginated.fromJson(d as Map<String, dynamic>, LandmarkItem.fromJson),
    );
    return res.data?.results ?? [];
  }
}

final landmarksRepositoryProvider = Provider<LandmarksRepository>(
    (ref) => LandmarksRepository(ref.read(apiClientProvider)));

/// Park = type 2
final parksProvider = FutureProvider<List<LandmarkItem>>((ref) async {
  return ref.read(landmarksRepositoryProvider).fetchByType(2);
});

/// Cami = type 1 (deneyelim)
final mosquesProvider = FutureProvider<List<LandmarkItem>>((ref) async {
  return ref.read(landmarksRepositoryProvider).fetchByType(1);
});

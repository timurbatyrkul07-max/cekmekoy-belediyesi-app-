import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../../../core/api/api_response.dart';

class FacilityCategory {
  final int id;
  final String name;
  final int count;
  final String? coverFilePath;

  const FacilityCategory({
    required this.id,
    required this.name,
    required this.count,
    this.coverFilePath,
  });

  factory FacilityCategory.fromJson(Map<String, dynamic> j) => FacilityCategory(
        id: j['id'] as int,
        name: j['name'] as String? ?? '',
        count: j['count'] as int? ?? 0,
        coverFilePath: j['coverFilePath'] as String?,
      );

  String get coverUrl => ApiConfig.fullFileUrl(coverFilePath);
}

class FacilityItem {
  final int id;
  final String name;
  final String? urlPath;
  final int? type;
  final String? typeName;
  final String? operatingHours;
  final String? coverFilePath;
  final String? address;
  final String? phone;

  const FacilityItem({
    required this.id,
    required this.name,
    this.urlPath,
    this.type,
    this.typeName,
    this.operatingHours,
    this.coverFilePath,
    this.address,
    this.phone,
  });

  factory FacilityItem.fromJson(Map<String, dynamic> j) => FacilityItem(
        id: j['id'] as int,
        name: j['name'] as String? ?? '',
        urlPath: j['urlPath'] as String?,
        type: j['type'] as int?,
        typeName: j['typeName'] as String?,
        operatingHours: j['operatingHours'] as String?,
        coverFilePath: j['coverFilePath'] as String?,
        address: j['address'] as String?,
        phone: j['phone'] as String?,
      );

  String get coverUrl => ApiConfig.fullFileUrl(coverFilePath);
}

class FacilitiesRepository {
  final ApiClient _client;
  FacilitiesRepository(this._client);

  Future<List<FacilityCategory>> fetchCategories() async {
    final raw = await _client.get('/api/public/facilities/categories');
    final dataRaw = raw['data'];
    if (dataRaw is List) {
      return dataRaw
          .whereType<Map<String, dynamic>>()
          .map(FacilityCategory.fromJson)
          .toList();
    }
    return [];
  }

  Future<List<FacilityItem>> fetchAll({int page = 1, int pageSize = 50}) async {
    final raw = await _client.get(
      '/api/public/facilities',
      query: {'page': page, 'pageSize': pageSize},
    );
    final res = ApiResponse.fromJson(
      raw,
      (d) => Paginated.fromJson(
          d as Map<String, dynamic>, FacilityItem.fromJson),
    );
    return res.data?.results ?? [];
  }

  Future<FacilityItem?> fetchById(int id) async {
    final raw = await _client.get('/api/public/facilities/$id');
    final res = ApiResponse.fromJson(
      raw,
      (d) => FacilityItem.fromJson(d as Map<String, dynamic>),
    );
    return res.data;
  }
}

final facilitiesRepositoryProvider = Provider<FacilitiesRepository>(
    (ref) => FacilitiesRepository(ref.read(apiClientProvider)));

final facilityCategoriesProvider =
    FutureProvider<List<FacilityCategory>>((ref) async {
  return ref.read(facilitiesRepositoryProvider).fetchCategories();
});

final facilitiesListProvider =
    FutureProvider<List<FacilityItem>>((ref) async {
  return ref.read(facilitiesRepositoryProvider).fetchAll();
});

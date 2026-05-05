import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../../../core/api/api_response.dart';

class Mukhtar {
  final int id;
  final String fullName;
  final String? phone;
  final String? email;
  final String? photoFilePath;

  const Mukhtar({
    required this.id,
    required this.fullName,
    this.phone,
    this.email,
    this.photoFilePath,
  });

  factory Mukhtar.fromJson(Map<String, dynamic> j) => Mukhtar(
        id: j['id'] as int,
        fullName: j['fullName'] as String? ?? '',
        phone: j['phone'] as String?,
        email: j['email'] as String?,
        photoFilePath: j['photoFilePath'] as String?,
      );

  String get photoUrl => ApiConfig.fullFileUrl(photoFilePath);
}

class NeighborhoodApiItem {
  final int id;
  final String name;
  final String? description;
  final double? lat;
  final double? lng;
  final String? coverFilePath;
  final Mukhtar? mukhtar;

  const NeighborhoodApiItem({
    required this.id,
    required this.name,
    this.description,
    this.lat,
    this.lng,
    this.coverFilePath,
    this.mukhtar,
  });

  factory NeighborhoodApiItem.fromJson(Map<String, dynamic> j) {
    return NeighborhoodApiItem(
      id: j['id'] as int,
      name: j['name'] as String? ?? '',
      description: j['description'] as String?,
      lat: (j['lat'] as num?)?.toDouble(),
      lng: (j['lng'] as num?)?.toDouble(),
      coverFilePath: j['coverFilePath'] as String?,
      mukhtar: j['mukhtar'] is Map<String, dynamic>
          ? Mukhtar.fromJson(j['mukhtar'] as Map<String, dynamic>)
          : null,
    );
  }
}

class NeighborhoodsRepository {
  final ApiClient _client;
  NeighborhoodsRepository(this._client);

  Future<List<NeighborhoodApiItem>> fetch() async {
    final raw = await _client.get('/api/public/neighborhoods');
    final dataRaw = raw['data'];
    if (dataRaw is List) {
      return dataRaw
          .whereType<Map<String, dynamic>>()
          .map(NeighborhoodApiItem.fromJson)
          .toList();
    }
    final res = ApiResponse.fromJson(
      raw,
      (d) => Paginated.fromJson(
          d as Map<String, dynamic>, NeighborhoodApiItem.fromJson),
    );
    return res.data?.results ?? [];
  }
}

final neighborhoodsRepositoryProvider = Provider<NeighborhoodsRepository>(
    (ref) => NeighborhoodsRepository(ref.read(apiClientProvider)));

final neighborhoodsListProvider =
    FutureProvider<List<NeighborhoodApiItem>>((ref) async {
  return ref.read(neighborhoodsRepositoryProvider).fetch();
});

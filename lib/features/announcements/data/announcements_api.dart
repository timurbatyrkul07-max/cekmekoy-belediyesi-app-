import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../../../core/api/api_response.dart';
import '../../../shared/models/content_item.dart';
import '../../news/data/news_api.dart';

class AnnouncementApiItem {
  final int id;
  final String title;
  final String? summary;
  final String? content;
  final String? coverFilePath;
  final DateTime publishStartAt;

  const AnnouncementApiItem({
    required this.id,
    required this.title,
    this.summary,
    this.content,
    this.coverFilePath,
    required this.publishStartAt,
  });

  factory AnnouncementApiItem.fromJson(Map<String, dynamic> json) {
    return AnnouncementApiItem(
      id: json['id'] as int,
      title: (json['title'] as String?) ?? '',
      summary: json['summary'] as String?,
      content: json['content'] as String?,
      coverFilePath: json['coverFilePath'] as String?,
      publishStartAt: DateTime.tryParse(json['publishStartAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  ContentItem toContentItem() {
    return ContentItem(
      id: 'a$id',
      type: ContentType.announcement,
      title: NewsApiItem.fromJson({'id': 0, 'title': title, 'publishStartAt': ''})
          .toContentItem()
          .title,
      summary: _strip(summary ?? ''),
      body: _strip(content ?? summary ?? ''),
      imageUrl: ApiConfig.fullFileUrl(coverFilePath),
      date: publishStartAt,
      category: 'Duyuru',
    );
  }

  static String _strip(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .trim();
  }
}

class AnnouncementsRepository {
  final ApiClient _client;
  AnnouncementsRepository(this._client);

  Future<List<AnnouncementApiItem>> fetch({int page = 1, int pageSize = 20}) async {
    final raw = await _client.get(
      '/api/public/announcements',
      query: {'page': page, 'pageSize': pageSize},
    );
    final res = ApiResponse.fromJson(
      raw,
      (data) => Paginated.fromJson(
          data as Map<String, dynamic>, AnnouncementApiItem.fromJson),
    );
    return res.data?.results ?? [];
  }
}

final announcementsRepositoryProvider = Provider<AnnouncementsRepository>(
    (ref) => AnnouncementsRepository(ref.read(apiClientProvider)));

final announcementsListProvider = FutureProvider<List<ContentItem>>((ref) async {
  final repo = ref.read(announcementsRepositoryProvider);
  final items = await repo.fetch();
  return items.map((e) => e.toContentItem()).toList();
});

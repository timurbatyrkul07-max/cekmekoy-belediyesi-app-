import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../../../core/api/api_response.dart';
import '../../../shared/models/content_item.dart';

class NewsApiItem {
  final int id;
  final String title;
  final String? summary;
  final String? content;
  final int? categoryId;
  final String? categoryName;
  final String? coverFilePath;
  final DateTime publishStartAt;

  const NewsApiItem({
    required this.id,
    required this.title,
    this.summary,
    this.content,
    this.categoryId,
    this.categoryName,
    this.coverFilePath,
    required this.publishStartAt,
  });

  factory NewsApiItem.fromJson(Map<String, dynamic> json) {
    return NewsApiItem(
      id: json['id'] as int,
      title: (json['title'] as String?) ?? '',
      summary: json['summary'] as String?,
      content: json['content'] as String?,
      categoryId: json['categoryId'] as int?,
      categoryName: json['categoryName'] as String?,
      coverFilePath: json['coverFilePath'] as String?,
      publishStartAt: DateTime.tryParse(json['publishStartAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  ContentItem toContentItem() {
    return ContentItem(
      id: id.toString(),
      type: ContentType.news,
      title: _stripHtml(title),
      summary: _stripHtml(summary ?? ''),
      body: _stripHtml(content ?? summary ?? ''),
      imageUrl: ApiConfig.fullFileUrl(coverFilePath),
      date: publishStartAt,
      category: categoryName,
    );
  }

  static String _stripHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .trim();
  }
}

class NewsRepository {
  final ApiClient _client;
  NewsRepository(this._client);

  Future<Paginated<NewsApiItem>> fetchNews({int page = 1, int pageSize = 20}) async {
    final raw = await _client.get(
      '/api/public/news',
      query: {'page': page, 'pageSize': pageSize},
    );
    final res = ApiResponse.fromJson(
      raw,
      (data) => Paginated.fromJson(
        data as Map<String, dynamic>,
        NewsApiItem.fromJson,
      ),
    );
    if (!res.isSuccess || res.data == null) {
      return Paginated(
        currentPage: 1,
        pageCount: 1,
        pageSize: 0,
        rowCount: 0,
        results: const [],
      );
    }
    return res.data!;
  }

  Future<NewsApiItem?> fetchById(int id) async {
    final raw = await _client.get('/api/public/news/$id');
    final res = ApiResponse.fromJson(
      raw,
      (data) => NewsApiItem.fromJson(data as Map<String, dynamic>),
    );
    return res.data;
  }
}

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepository(ref.read(apiClientProvider));
});

final newsListProvider = FutureProvider<List<ContentItem>>((ref) async {
  final repo = ref.read(newsRepositoryProvider);
  final result = await repo.fetchNews(page: 1, pageSize: 20);
  return result.results.map((e) => e.toContentItem()).toList();
});

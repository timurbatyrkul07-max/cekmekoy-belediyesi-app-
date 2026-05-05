import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../../../core/api/api_response.dart';
import '../../../shared/models/content_item.dart';

class EventApiItem {
  final int id;
  final String title;
  final String? summary;
  final String? content;
  final String? coverFilePath;
  final String? venueName;
  final DateTime publishStartAt;
  final DateTime? eventDate;

  const EventApiItem({
    required this.id,
    required this.title,
    this.summary,
    this.content,
    this.coverFilePath,
    this.venueName,
    required this.publishStartAt,
    this.eventDate,
  });

  factory EventApiItem.fromJson(Map<String, dynamic> json) {
    return EventApiItem(
      id: json['id'] as int,
      title: (json['title'] as String?) ?? '',
      summary: json['summary'] as String?,
      content: json['content'] as String?,
      coverFilePath: json['coverFilePath'] as String?,
      venueName: json['venueName'] as String?,
      publishStartAt: DateTime.tryParse(json['publishStartAt'] as String? ?? '') ??
          DateTime.now(),
      eventDate: DateTime.tryParse(json['eventDate'] as String? ?? ''),
    );
  }

  ContentItem toContentItem() {
    final d = eventDate ?? publishStartAt;
    return ContentItem(
      id: 'e$id',
      type: ContentType.event,
      title: _strip(title),
      summary: _strip(summary ?? ''),
      body: _strip(content ?? summary ?? ''),
      imageUrl: ApiConfig.fullFileUrl(coverFilePath),
      date: d,
      category: 'Etkinlik',
      location: venueName,
    );
  }

  static String _strip(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }
}

class EventsRepository {
  final ApiClient _client;
  EventsRepository(this._client);

  Future<List<EventApiItem>> fetch({int page = 1, int pageSize = 30}) async {
    final raw = await _client.get(
      '/api/public/events',
      query: {'page': page, 'pageSize': pageSize},
    );
    final dataRaw = raw['data'];
    if (dataRaw == null) return [];
    if (dataRaw is List) {
      return dataRaw
          .whereType<Map<String, dynamic>>()
          .map(EventApiItem.fromJson)
          .toList();
    }
    final res = ApiResponse.fromJson(
      raw,
      (data) =>
          Paginated.fromJson(data as Map<String, dynamic>, EventApiItem.fromJson),
    );
    return res.data?.results ?? [];
  }
}

final eventsRepositoryProvider = Provider<EventsRepository>(
    (ref) => EventsRepository(ref.read(apiClientProvider)));

final eventsListProvider = FutureProvider<List<ContentItem>>((ref) async {
  final items = await ref.read(eventsRepositoryProvider).fetch();
  return items.map((e) => e.toContentItem()).toList();
});

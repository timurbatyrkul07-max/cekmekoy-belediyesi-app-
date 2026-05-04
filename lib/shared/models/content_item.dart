enum ContentType { news, announcement, event, course }

class ContentItem {
  final String id;
  final ContentType type;
  final String title;
  final String summary;
  final String body;
  final String imageUrl;
  final DateTime date;
  final String? category;
  final String? location;

  const ContentItem({
    required this.id,
    required this.type,
    required this.title,
    required this.summary,
    required this.body,
    required this.imageUrl,
    required this.date,
    this.category,
    this.location,
  });
}

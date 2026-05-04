enum NotificationCategory { announcement, news, event, reminder, payment, request }

extension NotificationCategoryX on NotificationCategory {
  String get label => switch (this) {
        NotificationCategory.announcement => 'Duyuru',
        NotificationCategory.news => 'Haber',
        NotificationCategory.event => 'Etkinlik',
        NotificationCategory.reminder => 'Hatırlatma',
        NotificationCategory.payment => 'Ödeme',
        NotificationCategory.request => 'Talep',
      };
}

class AppNotification {
  final String id;
  final NotificationCategory category;
  final String title;
  final String body;
  final DateTime date;
  final bool read;
  final String? route;

  const AppNotification({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.date,
    this.read = false,
    this.route,
  });

  AppNotification copyWith({bool? read}) => AppNotification(
        id: id,
        category: category,
        title: title,
        body: body,
        date: date,
        read: read ?? this.read,
        route: route,
      );
}

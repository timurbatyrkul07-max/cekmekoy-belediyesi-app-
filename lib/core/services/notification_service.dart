import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/models/app_notification.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _channelId = 'cekmekoy_default';
  static const _channelName = 'Çekmeköy Bildirimleri';
  static const _prefKey = 'notifications_enabled';

  Future<void> init() async {
    if (_initialized) return;
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
    );
    _initialized = true;
  }

  Future<bool> requestPermission() async {
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      final granted = await ios.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    }
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      return granted ?? false;
    }
    return false;
  }

  Future<void> show(AppNotification notification) async {
    if (!_initialized) return;
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: notification.title,
      body: notification.body,
      notificationDetails: const NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: notification.route,
    );
  }

  Future<bool> isEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefKey) ?? true;
  }

  Future<void> setEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, value);
  }
}

class NotificationListNotifier extends Notifier<List<AppNotification>> {
  @override
  List<AppNotification> build() => _seedData();

  static List<AppNotification> _seedData() {
    final now = DateTime.now();
    return [
      AppNotification(
        id: '1',
        category: NotificationCategory.announcement,
        title: 'Çekmeköy Kent Lokantası açıldı',
        body: 'Vatandaşlarımız için uygun fiyatlı yemek hizmeti başladı.',
        date: now.subtract(const Duration(minutes: 30)),
      ),
      AppNotification(
        id: '2',
        category: NotificationCategory.event,
        title: 'Yılmaz Morgül Anneler Günü Konseri',
        body: "Anneler Günü'ne özel ücretsiz konser 11 Mayıs'ta.",
        date: now.subtract(const Duration(hours: 4)),
      ),
      AppNotification(
        id: '3',
        category: NotificationCategory.news,
        title: 'Çekmeköy Akademi Kayıtları',
        body: 'Yeni dönem ön kayıtlarına son 3 gün.',
        date: now.subtract(const Duration(days: 1)),
        read: true,
      ),
      AppNotification(
        id: '4',
        category: NotificationCategory.reminder,
        title: 'Emlak Vergisi Son Ödeme',
        body: '1. taksit son ödeme tarihi 31 Mayıs 2026.',
        date: now.subtract(const Duration(days: 2)),
        read: true,
      ),
      AppNotification(
        id: '5',
        category: NotificationCategory.request,
        title: 'Talebiniz İşleme Alındı',
        body: 'TLP-2026-1547 numaralı talebiniz ilgili müdürlüğe iletildi.',
        date: now.subtract(const Duration(days: 3)),
        read: true,
      ),
    ];
  }

  void markAsRead(String id) {
    state = state.map((n) => n.id == id ? n.copyWith(read: true) : n).toList();
  }

  void markAllRead() {
    state = state.map((n) => n.copyWith(read: true)).toList();
  }

  void addLocal(AppNotification notification) {
    state = [notification, ...state];
  }
}

final notificationListProvider =
    NotifierProvider<NotificationListNotifier, List<AppNotification>>(
  NotificationListNotifier.new,
);

final unreadCountProvider = Provider<int>((ref) {
  return ref.watch(notificationListProvider).where((n) => !n.read).length;
});

class NotificationsEnabledNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    return ref.read(notificationServiceProvider).isEnabled();
  }

  Future<void> toggle(bool value) async {
    state = const AsyncValue.loading();
    await ref.read(notificationServiceProvider).setEnabled(value);
    if (value) {
      await ref.read(notificationServiceProvider).requestPermission();
    }
    state = AsyncValue.data(value);
    if (kDebugMode) debugPrint('Notifications enabled: $value');
  }
}

final notificationsEnabledProvider =
    AsyncNotifierProvider<NotificationsEnabledNotifier, bool>(
  NotificationsEnabledNotifier.new,
);

import 'package:flutter/material.dart';
import '../models/quick_action.dart';
import '../models/banner_item.dart';
import '../models/news_item.dart';

class MockData {
  MockData._();

  static const List<QuickAction> quickActions = [
    QuickAction(label: 'E-Belediye', icon: Icons.account_balance, route: '/ebelediye'),
    QuickAction(label: 'Toplanma\nAlanları', icon: Icons.warning_amber, route: '/assembly'),
    QuickAction(label: 'Nöbetçi\nEczane', icon: Icons.local_pharmacy, route: '/pharmacy'),
    QuickAction(label: 'Telefon\nRehberi', icon: Icons.contacts, route: '/contacts'),
    QuickAction(label: 'KEOS Kent\nRehberi', icon: Icons.map, route: '/keos'),
  ];

  static const List<QuickAction> stories = [
    QuickAction(label: 'Başkan', icon: Icons.person, route: '/mayor'),
    QuickAction(label: 'Spor Okulu', icon: Icons.sports_soccer, route: '/sport-school'),
    QuickAction(label: 'Akademi', icon: Icons.school, route: '/academy'),
    QuickAction(label: 'DASK 2026', icon: Icons.shield, route: '/dask'),
    QuickAction(label: 'Etkinlik', icon: Icons.event, route: '/events'),
    QuickAction(label: 'İletişim', icon: Icons.phone, route: '/contact'),
  ];

  static List<BannerItem> banners = [
    BannerItem(
      id: '1',
      title: 'Çekmeköy\nKent Lokantası',
      subtitle: 'Hizmete açıldı — uygun fiyat, kaliteli yemek',
      imageUrl: 'https://picsum.photos/seed/kentlokanta/800/400',
    ),
    BannerItem(
      id: '2',
      title: 'Spor Okulları\n2026 Kayıt',
      subtitle: 'Yeni dönem kayıtları başladı',
      imageUrl: 'https://picsum.photos/seed/sporokul/800/400',
    ),
    BannerItem(
      id: '3',
      title: 'Çekmeköy Akademi\nÖn Kayıt',
      subtitle: 'Ders destek atölyeleri açıldı',
      imageUrl: 'https://picsum.photos/seed/akademi/800/400',
    ),
    BannerItem(
      id: '4',
      title: 'Doğal Yaşam Alanı\n880 Hayvana Yuva',
      subtitle: 'Çekmeköy\'de hayvan dostu proje',
      imageUrl: 'https://picsum.photos/seed/dogal/800/400',
    ),
  ];

  static List<NewsItem> news = [
    NewsItem(
      id: '1',
      title: 'Çekmeköy Kent Lokantası hizmete başladı',
      summary: 'Vatandaşlarımız artık uygun fiyatla kaliteli yemek hizmetine erişebilecek.',
      imageUrl: 'https://picsum.photos/seed/news1/400/300',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NewsItem(
      id: '2',
      title: 'Çekmeköy Akademi ders destek atölyeleri',
      summary: 'Öğrencilerimize özel ders destek atölyelerinde ön kayıtlar başladı.',
      imageUrl: 'https://picsum.photos/seed/news2/400/300',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    NewsItem(
      id: '3',
      title: 'Dev doğal yaşam alanı açıldı',
      summary: '880 hayvana güvenli yuva olacak doğal yaşam alanı hizmete girdi.',
      imageUrl: 'https://picsum.photos/seed/news3/400/300',
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];
}

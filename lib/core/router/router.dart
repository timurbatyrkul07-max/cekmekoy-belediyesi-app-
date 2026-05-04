import 'package:flutter/material.dart';
import '../../features/assembly/pages/assembly_page.dart';
import '../../features/department/pages/department_detail_page.dart';
import '../../features/events/pages/events_calendar_page.dart';
import '../../features/gallery/pages/gallery_page.dart';
import '../../features/mayor/pages/mayor_page.dart';
import '../../features/notifications/pages/notifications_page.dart';
import '../../features/obituary/pages/obituary_page.dart';
import '../../features/pharmacy/pages/pharmacy_page.dart';
import '../../features/request/pages/request_page.dart';
import '../../features/settings/pages/settings_page.dart';
import '../../features/webview/web_view_page.dart';
import '../../shared/data/content_data.dart';
import '../../shared/widgets/card_list_page.dart';
import '../../shared/widgets/menu_list_page.dart';

class AppRouter {
  AppRouter._();

  static const _portal = 'https://ebelediye.cekmekoy.bel.tr/webportal/';

  static const Map<String, _RouteConfig> _routes = {
    '/pay/tax': _RouteConfig.web(title: 'Vergi Ödeme', url: '${_portal}index.php?wwsayfa=20'),
    '/pay/calendar': _RouteConfig.web(title: 'Vergi Takvimi ve Beyanname', url: '${_portal}index.php?wwsayfa=17'),
    '/pay/banks': _RouteConfig.web(title: 'Banka ve Posta Bilgileri', url: '${_portal}index.php?wwsayfa=20'),
    '/pay/receipt': _RouteConfig.web(title: 'e-Makbuz', url: '${_portal}index.php?wwsayfa=26'),
    '/query/keos': _RouteConfig.web(title: 'KEOS Kent Rehberi', url: 'https://webgis.cekmekoy.bel.tr/keos/'),
    '/query/imar': _RouteConfig.web(title: 'İmar Sorgulama', url: '${_portal}index.php?wwsayfa=28'),
    '/query/permit': _RouteConfig.web(title: 'Ruhsat Sorgulama', url: '${_portal}index.php?wwsayfa=28'),
    '/query/registry': _RouteConfig.web(title: 'Sicil Sorgulama', url: '${_portal}index.php?wwsayfa=7010'),
    '/query/document': _RouteConfig.web(title: 'Evrak Takip', url: '${_portal}index.php?wwsayfa=46'),
    '/query/elevator': _RouteConfig.web(title: 'Asansör Periyodik Muayenesi', url: _portal),
    '/query/rayic': _RouteConfig.web(title: 'Rayiç Değerler', url: _portal),
    '/query/notices': _RouteConfig.web(title: 'Askıda İmar İlanları', url: 'https://www.cekmekoy.bel.tr/duyurular'),
    '/apply/info': _RouteConfig.web(title: 'Bilgi Edinme', url: 'https://www.cimer.gov.tr/'),
    '/apply/property': _RouteConfig.web(title: 'Emlak Beyan', url: '${_portal}index.php?wwsayfa=17'),
    '/apply/ad': _RouteConfig.web(title: 'İlan Reklam Beyan', url: '${_portal}index.php?wwsayfa=17'),
    '/apply/sport': _RouteConfig.web(title: 'Spor Tesisi Randevu', url: '${_portal}index.php?wwsayfa=8100'),
    '/apply/wedding': _RouteConfig.web(title: 'Nikah Randevu', url: '${_portal}index.php?wwsayfa=35'),
    '/apply/adopt': _RouteConfig.web(title: 'Hayvan Sahiplenme', url: 'https://www.cekmekoy.bel.tr/'),
    '/apply/baby': _RouteConfig.web(title: 'Hoş Geldin Bebek', url: 'https://www.cekmekoy.bel.tr/'),
    '/apply/disability': _RouteConfig.web(title: 'Engelli Hizmetleri', url: 'https://www.cekmekoy.bel.tr/'),
    '/apply/social-aid': _RouteConfig.web(title: 'Sosyal Yardım Hizmetleri', url: 'https://www.cekmekoy.bel.tr/'),
    '/apply/survey': _RouteConfig.web(title: 'Anketler', url: '${_portal}index.php?wwsayfa=8191'),
    '/ebelediye': _RouteConfig.web(title: 'E-Belediye', url: '${_portal}index.php?wwsayfa=25'),
    '/keos': _RouteConfig.web(title: 'KEOS Kent Rehberi', url: 'https://webgis.cekmekoy.bel.tr/keos/'),
    '/contacts': _RouteConfig.web(title: 'Telefon Rehberi', url: 'https://bulutkbs.gov.tr/Rehber/#/app?39430320'),
    '/tour': _RouteConfig.web(title: '360° Sanal Tur', url: 'https://www.cekmekoy.bel.tr/'),
    '/wifi': _RouteConfig.web(title: 'Ücretsiz Wifi Noktaları', url: 'https://www.cekmekoy.bel.tr/'),
    '/iett': _RouteConfig.web(title: 'İETT Saatleri', url: 'https://iett.istanbul/'),
    '/weekly': _RouteConfig.web(title: 'Haftanın Özeti', url: 'https://www.cekmekoy.bel.tr/'),
    '/services': _RouteConfig.web(title: 'Hizmet Rehberi', url: 'https://www.cekmekoy.bel.tr/hizmetler'),
  };

  static void open(BuildContext context, String route) {
    if (route == '/mayor') {
      _push(context, const MayorPage());
      return;
    }
    if (route == '/pharmacy') {
      _push(context, const PharmacyPage());
      return;
    }
    if (route == '/assembly') {
      _push(context, const AssemblyPage());
      return;
    }
    if (route == '/notifications') {
      _push(context, const NotificationsPage());
      return;
    }
    if (route == '/query/obituary') {
      _push(context, const ObituaryPage());
      return;
    }
    if (route == '/settings') {
      _push(context, const SettingsPage());
      return;
    }
    if (route == '/apply/request') {
      _push(context, const RequestPage());
      return;
    }
    if (route == '/news') {
      _push(context, _newsListPage());
      return;
    }
    if (route == '/events') {
      _push(context, const EventsCalendarPage());
      return;
    }
    if (route == '/announcements') {
      _push(context, _announcementsPage());
      return;
    }
    if (route == '/academy') {
      _push(context, _coursesPage());
      return;
    }
    if (route == '/parks') {
      _push(context, _staticListPage('Parklarımız', _parks));
      return;
    }
    if (route == '/mosques') {
      _push(context, _staticListPage('Camilerimiz', _mosques));
      return;
    }
    if (route == '/neighborhoods') {
      _push(context, _staticListPage('Mahalleler ve Muhtarlar', _neighborhoods));
      return;
    }
    if (route == '/facilities') {
      _push(context, _staticListPage('Sosyal Tesisler', _facilities));
      return;
    }
    if (route == '/brands') {
      _push(context, _staticListPage('Çekmeköy Markaları', _brands));
      return;
    }
    if (route == '/album') {
      _push(context, const GalleryPage());
      return;
    }
    if (route == '/departments') {
      _push(context, _departmentsPage());
      return;
    }
    final cfg = _routes[route];
    if (cfg != null) {
      _push(context, WebViewPage(title: cfg.title, url: cfg.url));
      return;
    }
    _push(context, _placeholder(route));
  }

  static void _push(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  static Widget _newsListPage() => CardListPage(title: 'Haberler', items: ContentData.news);
  static Widget _eventsListPage() => CardListPage(title: 'Etkinlikler', items: ContentData.events);
  static Widget _announcementsPage() => CardListPage(title: 'Duyurular', items: ContentData.announcements);
  static Widget _coursesPage() =>
      CardListPage(title: 'Çekmeköy Akademi', items: ContentData.courses, showDate: false);

  static Widget _staticListPage(String title, List<MenuListItem> items) =>
      MenuListPage(title: title, items: items, searchable: true);

  static Widget _departmentsPage() {
    return MenuListPage(
      title: 'Müdürlükler',
      searchable: true,
      items: DepartmentData.departments
          .map((d) => MenuListItem(
                label: d.name,
                icon: Icons.business_center,
                onTap: () {
                  _navKey.currentState?.push(
                    MaterialPageRoute(builder: (_) => DepartmentDetailPage(department: d)),
                  );
                },
              ))
          .toList(),
    );
  }

  static final _navKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navigatorKey => _navKey;

  static Widget _placeholder(String route) => Scaffold(
        appBar: AppBar(title: Text(route)),
        body: const Center(child: Text('Yakında')),
      );

  // Static menu lists
  static const _parks = [
    MenuListItem(label: 'Çekmeköy Millet Bahçesi', icon: Icons.park),
    MenuListItem(label: 'Mehmet Akif Ersoy Parkı', icon: Icons.park),
    MenuListItem(label: 'Hamidiye Mehmetçik Parkı', icon: Icons.park),
    MenuListItem(label: 'Mimar Sinan Parkı', icon: Icons.park),
    MenuListItem(label: 'Soğukpınar Tabiat Parkı', icon: Icons.park),
    MenuListItem(label: 'Çamlık Botanik Bahçesi', icon: Icons.park),
    MenuListItem(label: 'Taşdelen Aile Parkı', icon: Icons.park),
    MenuListItem(label: 'Ekşioğlu Çocuk Parkı', icon: Icons.park),
  ];

  static const _mosques = [
    MenuListItem(label: 'Merkez Camii', icon: Icons.mosque),
    MenuListItem(label: 'Çamlık Camii', icon: Icons.mosque),
    MenuListItem(label: 'Mimar Sinan Camii', icon: Icons.mosque),
    MenuListItem(label: 'Hamidiye Camii', icon: Icons.mosque),
    MenuListItem(label: 'Hüseyinli Camii', icon: Icons.mosque),
    MenuListItem(label: 'Mehmet Akif Ersoy Camii', icon: Icons.mosque),
    MenuListItem(label: 'Taşdelen Merkez Camii', icon: Icons.mosque),
    MenuListItem(label: 'Soğukpınar Camii', icon: Icons.mosque),
  ];

  static const _neighborhoods = [
    MenuListItem(label: 'Merkez Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Çamlık Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Çatalmeşe Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Ekşioğlu Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Hamidiye Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Hüseyinli Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Kirazlıdere Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Mehmet Akif Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Mimar Sinan Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Soğukpınar Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Taşdelen Mahallesi', icon: Icons.location_on),
    MenuListItem(label: 'Ömerli Mahallesi', icon: Icons.location_on),
  ];

  static const _facilities = [
    MenuListItem(label: 'Çekmeköy Bilim Merkezi', icon: Icons.science),
    MenuListItem(label: 'Çekmeköy Kent Lokantası', icon: Icons.restaurant),
    MenuListItem(label: 'Kültür Merkezleri', icon: Icons.theater_comedy),
    MenuListItem(label: 'Kütüphaneler', icon: Icons.menu_book),
    MenuListItem(label: 'Spor Salonları', icon: Icons.fitness_center),
    MenuListItem(label: 'Yüzme Havuzları', icon: Icons.pool),
    MenuListItem(label: 'Nikah Salonları', icon: Icons.favorite),
    MenuListItem(label: 'Veteriner Klinikleri', icon: Icons.pets),
    MenuListItem(label: 'Sosyal Yaşam Merkezleri', icon: Icons.diversity_3),
    MenuListItem(label: 'Bilgi Evleri', icon: Icons.school),
  ];

  static const _brands = [
    MenuListItem(label: 'Çekmeköy Kent Lokantası', icon: Icons.restaurant),
    MenuListItem(label: 'Çekmeköy Akademi', icon: Icons.school),
    MenuListItem(label: 'Çekmeköy Bilim Merkezi', icon: Icons.science),
    MenuListItem(label: 'Çekmeköy Spor Okulları', icon: Icons.sports),
    MenuListItem(label: 'Çekmeköy Kreş', icon: Icons.child_care),
  ];

  static const _album = [
    MenuListItem(label: '23 Nisan Çocuk Şenliği 2026', icon: Icons.photo_library),
    MenuListItem(label: '1 Mayıs Kutlamaları 2026', icon: Icons.photo_library),
    MenuListItem(label: 'Çekmeköy Bahar Festivali', icon: Icons.photo_library),
    MenuListItem(label: 'Spor Şöleni', icon: Icons.photo_library),
    MenuListItem(label: 'Doğal Yaşam Alanı Açılışı', icon: Icons.photo_library),
    MenuListItem(label: 'Kent Lokantası Açılışı', icon: Icons.photo_library),
  ];

  static const _departments = [
    MenuListItem(label: 'Basın, Yayın ve Halkla İlişkiler Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Bilgi İşlem Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Destek Hizmetleri Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Emlak ve İstimlak Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Fen İşleri Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Gençlik ve Spor Hizmetleri Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'İklim Değişikliği ve Sıfır Atık Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'İmar ve Şehircilik Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'İnsan Kaynakları ve Eğitim Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Kentsel Dönüşüm Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Kültür, Sanat ve Sosyal İşler Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Mali Hizmetler Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Özel Kalem Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Plan ve Proje Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Zabıta Müdürlüğü', icon: Icons.business_center),
    MenuListItem(label: 'Hukuk İşleri Müdürlüğü', icon: Icons.business_center),
  ];
}

class _RouteConfig {
  final String title;
  final String url;
  const _RouteConfig.web({required this.title, required this.url});
}

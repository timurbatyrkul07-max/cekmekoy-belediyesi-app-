import 'package:flutter/material.dart';

class MenuItem {
  final String label;
  final IconData icon;
  final String route;

  const MenuItem({required this.label, required this.icon, required this.route});
}

class MenuGroup {
  final String title;
  final IconData icon;
  final List<MenuItem> items;

  const MenuGroup({required this.title, required this.icon, required this.items});
}

class MenuData {
  MenuData._();

  static const List<MenuGroup> eMunicipality = [
    MenuGroup(
      title: 'E-Ödeme',
      icon: Icons.credit_card,
      items: [
        MenuItem(label: 'Vergi Ödeme', icon: Icons.payments, route: '/pay/tax'),
        MenuItem(label: 'Vergi Takvimi ve Beyanname', icon: Icons.calendar_month, route: '/pay/calendar'),
        MenuItem(label: 'Banka ve Posta Bilgileri', icon: Icons.account_balance, route: '/pay/banks'),
        MenuItem(label: 'e-Makbuz', icon: Icons.receipt, route: '/pay/receipt'),
      ],
    ),
    MenuGroup(
      title: 'E-Sorgulama',
      icon: Icons.help_outline,
      items: [
        MenuItem(label: 'Çekmeköy Kent Rehberi (KEOS)', icon: Icons.map, route: '/query/keos'),
        MenuItem(label: 'İmar Sorgulama', icon: Icons.business, route: '/query/imar'),
        MenuItem(label: 'Ruhsat Sorgulama', icon: Icons.assignment_turned_in, route: '/query/permit'),
        MenuItem(label: 'Sicil Sorgulama', icon: Icons.badge, route: '/query/registry'),
        MenuItem(label: 'Evrak Takip', icon: Icons.find_in_page, route: '/query/document'),
        MenuItem(label: 'Asansör Periyodik Muayenesi', icon: Icons.elevator, route: '/query/elevator'),
        MenuItem(label: 'Vefat Edenler', icon: Icons.church, route: '/query/obituary'),
        MenuItem(label: 'Rayiç Değerler', icon: Icons.trending_up, route: '/query/rayic'),
        MenuItem(label: 'Askıda İmar/Plan İlanları', icon: Icons.list_alt, route: '/query/notices'),
      ],
    ),
    MenuGroup(
      title: 'E-Başvuru',
      icon: Icons.assignment,
      items: [
        MenuItem(label: 'Talep / Şikayet Formu', icon: Icons.send, route: '/apply/request'),
        MenuItem(label: 'Bilgi Edinme', icon: Icons.info_outline, route: '/apply/info'),
        MenuItem(label: 'Emlak Beyan Oluşturma', icon: Icons.home_work, route: '/apply/property'),
        MenuItem(label: 'İlan Reklam Beyan', icon: Icons.campaign, route: '/apply/ad'),
        MenuItem(label: 'Spor Tesisi Randevu', icon: Icons.fitness_center, route: '/apply/sport'),
        MenuItem(label: 'Nikah Randevu', icon: Icons.favorite, route: '/apply/wedding'),
        MenuItem(label: 'Hayvan Sahiplenme', icon: Icons.pets, route: '/apply/adopt'),
        MenuItem(label: 'Hoş Geldin Bebek', icon: Icons.child_care, route: '/apply/baby'),
        MenuItem(label: 'Engelli Hizmetleri', icon: Icons.accessible, route: '/apply/disability'),
        MenuItem(label: 'Sosyal Yardım Hizmetleri', icon: Icons.volunteer_activism, route: '/apply/social-aid'),
        MenuItem(label: 'Anketler', icon: Icons.poll, route: '/apply/survey'),
      ],
    ),
  ];

  static const List<MenuItem> municipality = [
    MenuItem(label: 'Haftanın Özeti', icon: Icons.menu_book, route: '/weekly'),
    MenuItem(label: 'Çekmeköy Akademi', icon: Icons.school, route: '/academy'),
    MenuItem(label: 'Hizmet Rehberi', icon: Icons.menu_book_outlined, route: '/services'),
    MenuItem(label: 'Nöbetçi Eczaneler', icon: Icons.local_pharmacy, route: '/pharmacy'),
    MenuItem(label: 'Sosyal Tesisler', icon: Icons.apartment, route: '/facilities'),
    MenuItem(label: 'Parklarımız', icon: Icons.park, route: '/parks'),
    MenuItem(label: 'Camilerimiz', icon: Icons.mosque, route: '/mosques'),
    MenuItem(label: 'Mahalleler ve Muhtarlar', icon: Icons.location_on, route: '/neighborhoods'),
    MenuItem(label: 'İETT Saatleri', icon: Icons.directions_bus, route: '/iett'),
    MenuItem(label: 'Toplanma Alanları', icon: Icons.warning, route: '/assembly'),
    MenuItem(label: 'Yuva Arıyorum', icon: Icons.pets, route: '/adopt'),
    MenuItem(label: '360° Sanal Tur', icon: Icons.threed_rotation, route: '/tour'),
    MenuItem(label: 'Çekmeköy Markaları', icon: Icons.storefront, route: '/brands'),
    MenuItem(label: 'Ücretsiz Wifi Noktaları', icon: Icons.wifi, route: '/wifi'),
    MenuItem(label: 'Çekmeköy Albümü', icon: Icons.photo_library, route: '/album'),
    MenuItem(label: 'Telefon Rehberi', icon: Icons.contacts, route: '/contacts'),
  ];

  static const List<MenuItem> corporate = [
    MenuItem(label: 'Başkan', icon: Icons.person, route: '/mayor'),
    MenuItem(label: 'Başkan Yardımcıları', icon: Icons.people, route: '/deputies'),
    MenuItem(label: 'Meclis', icon: Icons.account_balance, route: '/council'),
    MenuItem(label: 'Encümen', icon: Icons.gavel, route: '/encumen'),
    MenuItem(label: 'Müdürlükler', icon: Icons.business_center, route: '/departments'),
    MenuItem(label: 'Organizasyon Şeması', icon: Icons.account_tree, route: '/org-chart'),
    MenuItem(label: 'Vizyon - Misyon', icon: Icons.flag, route: '/vision'),
    MenuItem(label: 'Politikalarımız', icon: Icons.policy, route: '/policies'),
    MenuItem(label: 'KVKK', icon: Icons.security, route: '/kvkk'),
    MenuItem(label: 'Etik Komisyonu', icon: Icons.balance, route: '/ethics'),
    MenuItem(label: 'Entegre Yönetim Sistemi (EYS)', icon: Icons.workspace_premium, route: '/eys'),
    MenuItem(label: 'Stratejik Plan', icon: Icons.assessment, route: '/strategy'),
    MenuItem(label: 'Mevzuat', icon: Icons.menu_book, route: '/regulations'),
    MenuItem(label: 'Yayınlarımız', icon: Icons.newspaper, route: '/publications'),
    MenuItem(label: 'Kardeş Şehirler', icon: Icons.public, route: '/sister-cities'),
    MenuItem(label: 'Çekmeköy Markaları', icon: Icons.storefront, route: '/brands'),
    MenuItem(label: 'Basın İçin', icon: Icons.campaign, route: '/press'),
  ];
}

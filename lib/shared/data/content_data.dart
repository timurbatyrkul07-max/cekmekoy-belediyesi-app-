import '../models/content_item.dart';

class ContentData {
  ContentData._();

  static final List<ContentItem> news = [
    ContentItem(
      id: 'n1',
      type: ContentType.news,
      title: 'Çekmeköy Kent Lokantası Hizmete Başladı',
      summary: 'Vatandaşlarımız uygun fiyatla kaliteli yemek hizmetine erişebilecek.',
      body:
          'Çekmeköy Belediyesi tarafından açılan Kent Lokantası, vatandaşlarımıza uygun fiyatla sağlıklı ve kaliteli yemek sunmaya başladı. Açılışta konuşan Belediye Başkanı Orhan Çerkez, sosyal belediyecilik anlayışıyla bu projeyi hayata geçirdiklerini belirtti.',
      imageUrl: 'https://picsum.photos/seed/news1/800/500',
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Sosyal',
    ),
    ContentItem(
      id: 'n2',
      type: ContentType.news,
      title: 'Çekmeköy Akademi Ders Destek Atölyelerinde Ön Kayıtlar Başladı',
      summary: 'Öğrencilerimize özel ders destek atölyelerinde ön kayıtlar açıldı.',
      body:
          'Çekmeköy Akademi bünyesinde açılan ders destek atölyeleri, ortaokul ve lise öğrencilerine yönelik ücretsiz hizmet veriyor. Matematik, Türkçe, Fen Bilgisi, İngilizce derslerinde uzman öğretmenlerle çalışma imkânı sunuluyor.',
      imageUrl: 'https://picsum.photos/seed/news2/800/500',
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: 'Eğitim',
    ),
    ContentItem(
      id: 'n3',
      type: ContentType.news,
      title: 'Dev Doğal Yaşam Alanı Açıldı: 880 Hayvana Güvenli Yuva',
      summary: 'Çekmeköy\'de hayvan dostlarımız için modern bir yaşam alanı oluşturuldu.',
      body:
          'Çekmeköy Belediyesi, sokak hayvanları için 880 hayvan kapasiteli doğal yaşam alanını hizmete açtı. Alan içerisinde veteriner kliniği, rehabilitasyon merkezi ve sahiplendirme bölümü bulunuyor.',
      imageUrl: 'https://picsum.photos/seed/news3/800/500',
      date: DateTime.now().subtract(const Duration(days: 4)),
      category: 'Çevre',
    ),
    ContentItem(
      id: 'n4',
      type: ContentType.news,
      title: 'Emekçilerle Omuz Omuza 1 Mayıs Kutlaması',
      summary: 'Çekmeköy Belediyesi 1 Mayıs Emek ve Dayanışma Günü\'nü coşkuyla kutladı.',
      body:
          '1 Mayıs Emek ve Dayanışma Günü\'nde belediye personeli ve vatandaşlarla bir araya gelen Başkan Orhan Çerkez, emekçilere desteğini bildirdi.',
      imageUrl: 'https://picsum.photos/seed/news4/800/500',
      date: DateTime(2026, 5, 1),
      category: 'Genel',
    ),
    ContentItem(
      id: 'n5',
      type: ContentType.news,
      title: 'Çekmeköy Gençlik İklim Eylem Fonu\'na Kabul Edildi',
      summary: 'Çekmeköy, uluslararası iklim eylem ağına kabul edildi.',
      body:
          'Belediyemiz, gençlik iklim eylem fonuna kabul edilen 12 Türk belediyesinden biri oldu. Bu kapsamda gençlerin liderliğinde iklim projeleri hayata geçirilecek.',
      imageUrl: 'https://picsum.photos/seed/news5/800/500',
      date: DateTime.now().subtract(const Duration(days: 7)),
      category: 'Çevre',
    ),
    ContentItem(
      id: 'n6',
      type: ContentType.news,
      title: 'Çekmeköy\'de 4 Gün Sürecek Çocuk Şenliği Coşkuyla Başladı',
      summary: '23 Nisan Ulusal Egemenlik ve Çocuk Bayramı dolu dolu kutlandı.',
      body:
          'Belediyemiz tarafından düzenlenen 4 gün sürecek çocuk şenliği, binlerce çocuğun katılımıyla başladı. Şenlik kapsamında konserler, gösteriler ve atölye etkinlikleri düzenleniyor.',
      imageUrl: 'https://picsum.photos/seed/news6/800/500',
      date: DateTime(2026, 4, 23),
      category: 'Etkinlik',
    ),
  ];

  static final List<ContentItem> announcements = [
    ContentItem(
      id: 'a1',
      type: ContentType.announcement,
      title: 'Hüseyinli Mahallesi 1/1000 Ölçekli İmar Plan Değişikliği',
      summary: '439 ve 516 parsele ilişkin uygulama imar planı askıya çıkmıştır.',
      body:
          'Hüseyinli Mahallesi 439 parsel ve bitişiğindeki kadastral boşluk ile 516 parsel ve 118 ada 1 parsele ilişkin 1/1000 ölçekli uygulama imar planı değişikliği 30 gün süreyle askıdadır.',
      imageUrl: 'https://picsum.photos/seed/ann1/800/500',
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: 'İmar',
    ),
    ContentItem(
      id: 'a2',
      type: ContentType.announcement,
      title: 'DASK 2026 Bilgilendirme',
      summary: 'Zorunlu Deprem Sigortası 2026 yılı bilgilendirme duyurusu.',
      body:
          'Zorunlu Deprem Sigortası (DASK) 2026 yılı için tüm konutlarımızın güncel sigorta poliçelerini kontrol etmelerini önemle hatırlatırız.',
      imageUrl: 'https://picsum.photos/seed/ann2/800/500',
      date: DateTime.now().subtract(const Duration(days: 5)),
      category: 'Bilgilendirme',
    ),
    ContentItem(
      id: 'a3',
      type: ContentType.announcement,
      title: 'Spor Okulu Yeni Dönem Kayıtları Başladı',
      summary: 'Çekmeköy Spor Okulu 2026 yaz dönemi kayıtları açıldı.',
      body:
          'Spor Okulumuzda futbol, basketbol, voleybol, yüzme, jimnastik, satranç branşlarında yeni dönem kayıtları başlamıştır. 7-15 yaş arası çocuklarımız ücretsiz katılabilir.',
      imageUrl: 'https://picsum.photos/seed/ann3/800/500',
      date: DateTime.now().subtract(const Duration(days: 6)),
      category: 'Spor',
    ),
  ];

  static final List<ContentItem> events = [
    ContentItem(
      id: 'e1',
      type: ContentType.event,
      title: 'Yılmaz Morgül Anneler Günü Konseri',
      summary: 'Anneler Günü\'ne özel ücretsiz konser.',
      body:
          'Anneler Günü\'ne özel olarak Yılmaz Morgül konser verecek. Etkinlik ücretsizdir, davetiye gerekmektedir.',
      imageUrl: 'https://picsum.photos/seed/ev1/800/500',
      date: DateTime(2026, 5, 11, 20, 0),
      category: 'Konser',
      location: 'Çekmeköy Kültür Merkezi',
    ),
    ContentItem(
      id: 'e2',
      type: ContentType.event,
      title: 'Küçük Prens (Çocuk Tiyatrosu)',
      summary: 'Çocuklarımız için ücretsiz tiyatro gösterisi.',
      body:
          'Klasikleşmiş eser "Küçük Prens" çocuklarımız için sahnede. 5+ yaş için uygundur.',
      imageUrl: 'https://picsum.photos/seed/ev2/800/500',
      date: DateTime(2026, 5, 8, 14, 0),
      category: 'Tiyatro',
      location: 'Mimar Sinan Kültür Merkezi',
    ),
    ContentItem(
      id: 'e3',
      type: ContentType.event,
      title: 'Pamuk Prenses (Çocuk Tiyatrosu)',
      summary: 'Klasik masal çocuklarımız için sahnede.',
      body: 'Pamuk Prenses ve Yedi Cüceler masalı çocuklarımız için sahnelenecek.',
      imageUrl: 'https://picsum.photos/seed/ev3/800/500',
      date: DateTime(2026, 5, 15, 14, 0),
      category: 'Tiyatro',
      location: 'Çamlık Kültür Merkezi',
    ),
    ContentItem(
      id: 'e4',
      type: ContentType.event,
      title: 'Gönülden Sesler Türk Müziği Topluluğu Konseri',
      summary: 'Türk Sanat Müziği konseri.',
      body: 'Türk müziği severler için unutulmaz bir akşam.',
      imageUrl: 'https://picsum.photos/seed/ev4/800/500',
      date: DateTime(2026, 5, 18, 20, 0),
      category: 'Konser',
      location: 'Çekmeköy Kültür Merkezi',
    ),
    ContentItem(
      id: 'e5',
      type: ContentType.event,
      title: 'Karagöz Hacivat ile Latifehane',
      summary: 'Geleneksel gölge oyunu çocuklarımızla buluşuyor.',
      body: 'Geleneksel sanatlarımızı çocuklarımızla buluşturuyoruz.',
      imageUrl: 'https://picsum.photos/seed/ev5/800/500',
      date: DateTime(2026, 5, 22, 14, 0),
      category: 'Tiyatro',
      location: 'Hamidiye Kültür Merkezi',
    ),
  ];

  static final List<ContentItem> courses = [
    ContentItem(
      id: 'c1',
      type: ContentType.course,
      title: 'Müzik Akademisi',
      summary: 'Piyano, gitar, keman, bağlama dersleri.',
      body: 'Çocuk ve yetişkinler için tüm enstrümanlarda eğitim. Başlangıç ve ileri seviye gruplar.',
      imageUrl: 'https://picsum.photos/seed/cs1/800/500',
      date: DateTime.now(),
      category: 'Çekmeköy Akademi',
    ),
    ContentItem(
      id: 'c2',
      type: ContentType.course,
      title: 'Dil Akademisi',
      summary: 'İngilizce, Almanca, Arapça kursları.',
      body: 'Tüm yaş grupları için dil eğitimi. KPDS, TOEFL, IELTS hazırlık programları.',
      imageUrl: 'https://picsum.photos/seed/cs2/800/500',
      date: DateTime.now(),
      category: 'Çekmeköy Akademi',
    ),
    ContentItem(
      id: 'c3',
      type: ContentType.course,
      title: 'Görsel Sanatlar Atölyesi',
      summary: 'Resim, ebru, hat sanatı.',
      body: 'Geleneksel ve modern sanatların buluştuğu atölyeler.',
      imageUrl: 'https://picsum.photos/seed/cs3/800/500',
      date: DateTime.now(),
      category: 'Sanat',
    ),
    ContentItem(
      id: 'c4',
      type: ContentType.course,
      title: 'Spor Akademisi',
      summary: 'Yüzme, futbol, basketbol, jimnastik.',
      body: 'Çocuklarımıza yönelik branş kursları. Ücretsiz olarak hizmet vermekteyiz.',
      imageUrl: 'https://picsum.photos/seed/cs4/800/500',
      date: DateTime.now(),
      category: 'Spor',
    ),
    ContentItem(
      id: 'c5',
      type: ContentType.course,
      title: 'Aile Gelişim Akademisi',
      summary: 'Ebeveynlik, çocuk psikolojisi seminerleri.',
      body: 'Aile eğitim programları, ebeveynlik becerileri, evlilik öncesi danışmanlık.',
      imageUrl: 'https://picsum.photos/seed/cs5/800/500',
      date: DateTime.now(),
      category: 'Aile',
    ),
    ContentItem(
      id: 'c6',
      type: ContentType.course,
      title: 'Meslek Edindirme Atölyesi',
      summary: 'Kuaförlük, terzilik, bilgisayar.',
      body: 'İstihdama yönelik meslek kursları, sertifika programları.',
      imageUrl: 'https://picsum.photos/seed/cs6/800/500',
      date: DateTime.now(),
      category: 'Meslek',
    ),
  ];
}

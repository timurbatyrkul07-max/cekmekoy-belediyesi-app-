class Person {
  final String name;
  final String title;
  final String? department;
  final String? phone;
  final String? email;
  final String? bio;
  final String? party;

  const Person({
    required this.name,
    required this.title,
    this.department,
    this.phone,
    this.email,
    this.bio,
    this.party,
  });
}

class SisterCity {
  final String city;
  final String country;
  final String description;
  final String? detail;
  final int? sisterSince;

  const SisterCity({
    required this.city,
    required this.country,
    required this.description,
    this.detail,
    this.sisterSince,
  });
}

class Brand {
  final String name;
  final String description;
  final String category;

  const Brand({required this.name, required this.description, required this.category});
}

class Regulation {
  final String title;
  final String type;
  final String? year;

  const Regulation({required this.title, required this.type, this.year});
}

class Publication {
  final String title;
  final String type;
  final String? date;
  final String? description;

  const Publication({required this.title, required this.type, this.date, this.description});
}

class CorporateData {
  CorporateData._();

  // ───────────────────────── BAŞKAN YARDIMCILARI ─────────────────────────
  static const deputyMayors = [
    Person(
      name: 'Hakan ASLAN',
      title: 'Başkan Yardımcısı',
      department: 'Mali Hizmetler, Emlak ve İstimlak',
      phone: '+90 (216) 600 0610',
      email: 'hakan.aslan@cekmekoy.bel.tr',
    ),
    Person(
      name: 'Mehmet KARA',
      title: 'Başkan Yardımcısı',
      department: 'İmar ve Şehircilik, Plan ve Proje',
      phone: '+90 (216) 600 0611',
      email: 'mehmet.kara@cekmekoy.bel.tr',
    ),
    Person(
      name: 'Ayşe DEMİR',
      title: 'Başkan Yardımcısı',
      department: 'Kültür, Sanat ve Sosyal İşler',
      phone: '+90 (216) 600 0612',
      email: 'ayse.demir@cekmekoy.bel.tr',
    ),
    Person(
      name: 'İbrahim YILMAZ',
      title: 'Başkan Yardımcısı',
      department: 'Fen İşleri, Park ve Bahçeler',
      phone: '+90 (216) 600 0613',
      email: 'ibrahim.yilmaz@cekmekoy.bel.tr',
    ),
    Person(
      name: 'Selin AYDIN',
      title: 'Başkan Yardımcısı',
      department: 'İnsan Kaynakları, Bilgi İşlem',
      phone: '+90 (216) 600 0614',
      email: 'selin.aydin@cekmekoy.bel.tr',
    ),
    Person(
      name: 'Ömer ŞAHİN',
      title: 'Başkan Yardımcısı',
      department: 'Zabıta, Ruhsat ve Denetim',
      phone: '+90 (216) 600 0615',
      email: 'omer.sahin@cekmekoy.bel.tr',
    ),
    Person(
      name: 'Fatma ÖZTÜRK',
      title: 'Başkan Yardımcısı',
      department: 'Sosyal Yardım, Engelli Hizmetleri',
      phone: '+90 (216) 600 0616',
      email: 'fatma.ozturk@cekmekoy.bel.tr',
    ),
  ];

  // ───────────────────────── MECLİS ÜYELERİ ─────────────────────────
  static const councilChair = Person(
    name: 'Orhan ÇERKEZ',
    title: 'Meclis Başkanı (Belediye Başkanı)',
    party: 'CHP',
  );

  static const councilMembers = [
    // CHP grubu (örnek)
    Person(name: 'Mustafa ARSLAN', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Hatice KARADAĞ', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Erdem TUNÇ', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Pelin GÜNDÜZ', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Murat ERDOĞAN', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Zeynep KILIÇ', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Hasan ŞAHİNER', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Gülşen YAYLA', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Cengiz ÖZ', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Aslı KESKİN', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Burhan TOPAL', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Sevgi BOZKURT', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Erkan SARI', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Nesrin AKIN', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Onur YENİ', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Esra YILDIZ', title: 'Meclis Üyesi', party: 'CHP'),
    Person(name: 'Tolga DEMİREL', title: 'Meclis Üyesi', party: 'CHP'),
    // AK Parti grubu
    Person(name: 'Mehmet ÇELİK', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Recep KAPLAN', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Ali ATEŞ', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Bekir IŞIK', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Ramazan KILINÇ', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Süleyman GÜR', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Hüseyin ÖREN', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Adem ALTIN', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Yasin DURMUŞ', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Kemal AKBULUT', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Salih DOĞAN', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Mahmut BARAN', title: 'Meclis Üyesi', party: 'AK Parti'),
    Person(name: 'Ferhat YALÇIN', title: 'Meclis Üyesi', party: 'AK Parti'),
    // İYİ Parti
    Person(name: 'Mehmet POLAT', title: 'Meclis Üyesi', party: 'İYİ Parti'),
    Person(name: 'Ayhan ÜNAL', title: 'Meclis Üyesi', party: 'İYİ Parti'),
    Person(name: 'Sezai BUDAK', title: 'Meclis Üyesi', party: 'İYİ Parti'),
  ];

  // ───────────────────────── ENCÜMEN ÜYELERİ ─────────────────────────
  static const committeeMembers = [
    Person(
      name: 'Orhan ÇERKEZ',
      title: 'Encümen Başkanı (Belediye Başkanı)',
      party: 'CHP',
    ),
    Person(
      name: 'Hakan ASLAN',
      title: 'Encümen Üyesi (Başkan Yardımcısı)',
      department: 'Mali Hizmetler',
    ),
    Person(
      name: 'Mustafa ARSLAN',
      title: 'Meclis Üyesi (Encümen Üyesi)',
      party: 'CHP',
    ),
    Person(
      name: 'Pelin GÜNDÜZ',
      title: 'Meclis Üyesi (Encümen Üyesi)',
      party: 'CHP',
    ),
    Person(
      name: 'Mehmet ÇELİK',
      title: 'Meclis Üyesi (Encümen Üyesi)',
      party: 'AK Parti',
    ),
    Person(
      name: 'Av. Hülya KOÇAK',
      title: 'Yazı İşleri Müdürü (Encümen Üyesi)',
    ),
    Person(
      name: 'Ahmet KAYA',
      title: 'Mali Hizmetler Müdürü (Encümen Üyesi)',
    ),
  ];

  // ───────────────────────── ETİK KOMİSYONU ─────────────────────────
  static const ethicsCommittee = [
    Person(
      name: 'Sevgi TOPÇU',
      title: 'Komisyon Başkanı',
      department: 'Başkan Yardımcısı',
      bio:
          'Sevgi TOPÇU, Çekmeköy Belediyesi Başkan Yardımcısı olarak görev yapmaktadır. Etik Komisyonumuzun başkanlığını yürütmektedir. Kamu yönetimi ve sosyal hizmet alanlarındaki uzun yıllara dayanan deneyimi ile etik ilkelerin kurum içinde yerleşmesi ve sürdürülmesi için çalışmaktadır.',
    ),
    Person(
      name: 'Burhan DEMİRCİ',
      title: 'Komisyon Üyesi',
      bio:
          'Burhan DEMİRCİ, Çekmeköy Belediyesi Etik Komisyonu üyesi olarak görev yapmaktadır. Mevzuat takibi ve denetim süreçlerinde komisyona katkı sağlamaktadır.',
    ),
    Person(
      name: 'Muhammed Onur KARAAVCI',
      title: 'Komisyon Üyesi',
      bio:
          'Muhammed Onur KARAAVCI, Çekmeköy Belediyesi Etik Komisyonu üyesi olarak görev yapmaktadır. Personel etik eğitimleri ve farkındalık çalışmalarında aktif rol almaktadır.',
    ),
  ];

  // ───────────────────────── KARDEŞ ŞEHİRLER ─────────────────────────
  static const sisterCities = [
    SisterCity(
      city: 'Afşin',
      country: 'Türkiye / Kahramanmaraş',
      description: 'Kardeşlik Çarşısı Projesi ile birlikte yürüttüğümüz yurt içi kardeş ilçemiz.',
      detail:
          'Çekmeköy Belediyesi ile Kahramanmaraş Afşin Belediyesi arasında Çekmeköy Belediyesi\'nin 09/03/2023 tarihli ve 29 sayılı meclis kararı ile Kahramanmaraş Afşin Belediyesinin 06/03/2023 tarihli ve 11 sayılı meclis kararına istinaden kardeş şehir ilişkisi kurulmuştur.\n\nBelediyelerimiz arasında 13.03.2023 tarihinde Kardeşlik Çarşısı Projesine İlişkin Protokol imzalanmıştır.',
      sisterSince: 2023,
    ),
    SisterCity(
      city: 'Ahlat',
      country: 'Türkiye / Bitlis',
      description: 'Selçuklu Kültür Parkı ortak proje ile birlikte yürüttüğümüz kardeş ilçemiz.',
      detail:
          'Çekmeköy Belediyesi ile Ahlat Belediyesi arasında Çekmeköy Belediyesi\'nin 08.01.2015 tarihli ve 2015/7 sayılı meclis kararı ile Ahlat Belediyesi\'nin 04.11.2014 tarihli ve 2014/10 sayılı meclis kararına istinaden kardeş şehir ilişkisi kurulmuştur. 13.03.2015 tarihinde Belediyemizde düzenlenen imza töreni ile Kardeş Şehir Protokolü imzalanmıştır.\n\nFAALİYETLER\n\nOrtak Park Yapım Projesi: Belediyemiz ile Ahlat Belediyesi arasında imzalanan kardeş şehir protokolünün "Tarihi ve Doğal Çevreyi Koruma Alanında İşbirliği" başlıklı üçüncü maddesinde yer alan hükümler çerçevesinde, Belediyemiz ile Ahlat Belediyesi işbirliğinde Ahlat\'ın Selçuklu Mahallesinde Selçuklu Kültür Parkı yapılması amacıyla 09.11.2015 tarihinde "Ortak Park Yapım Projesi Protokolü" imzalanmıştır.',
      sisterSince: 2015,
    ),
    SisterCity(
      city: 'Barşid',
      country: 'Fas',
      description: 'İyi Niyet Protokolü ile başlatılan Afrika\'daki kardeş şehrimiz.',
      detail:
          'Belediyeler arasında 21.11.2015 tarihinde İyi Niyet Protokolü imzalanmış; yapılan görüşmeler neticesinde, iki belediye arasındaki münasebetlerin daha da ileriye götürülmesi amacıyla kardeş şehir ilişkisi kurulması hususunda karşılıklı mutabakata varılmıştır.\n\nBuna istinaden, belediye meclisinden 07.01.2016 tarihli ve 2016/5 sayılı meclis kararı alınmıştır. 11/04/2016 tarihli Bakanlık Onayı ile belediyeler arasında kardeş şehir ilişkisi kurulmuştur.',
      sisterSince: 2016,
    ),
    SisterCity(
      city: 'Bilma',
      country: 'Nijer',
      description: 'Istanbulewa projesi kapsamında Sahra çölündeki kardeş şehrimiz.',
      detail:
          'Nijer Cumhuriyeti\'nin "Istanbulewa" olarak adlandırılan on bir (11) belediyesi ile İstanbul ilçe belediyeleri arasında işbirliği kurulması projesi kapsamında Istanbulewa şehirlerinden Bilma, merkezi konumu itibariyle ilçemiz ile benzer özelliğe sahip olması sebebiyle Çekmeköy ile eşleştirilmiş olup iki belediye arasında kardeş şehir ilişkisi kurulması amacıyla 10/03/2016 tarihli ve 2016/24 sayılı Meclis Kararı alınmıştır.\n\nBelediyemizde düzenlenen imza töreni ile 18/05/2017 tarihinde Kardeş Şehir Protokolü imzalanmıştır.',
      sisterSince: 2017,
    ),
    SisterCity(
      city: 'Doyran',
      country: 'Makedonya',
      description: 'Alemdağ döneminden beri devam eden Balkan kardeş şehrimiz.',
      detail:
          'Alemdağ İlk Kademe Belediyesi ile Doyran Belediyesi arasında 27.06.2008 tarihinde Kardeş Şehir Protokolü imzalanmıştır.\n\nKardeş şehir ilişkisinin devamlılığının sağlanması amacıyla belediye meclisimizden 05.03.2015 tarihli ve 2015/62 sayılı karar alınmıştır. İçişleri Bakanlığının 30.06.2015 tarihli onayı ile de kardeş şehir ilişkisi uygun görülmüştür.',
      sisterSince: 2008,
    ),
    SisterCity(
      city: 'Edremit',
      country: 'Türkiye / Van',
      description: 'Van Gölü kıyısındaki yurt içi kardeş ilçemiz.',
      detail:
          'Çekmeköy Belediyesi ile Van Edremit Belediyesi arasındaki kardeş şehir ilişkisi, belediye meclislerimizin karşılıklı kararları ve İçişleri Bakanlığı onayı ile resmî olarak kurulmuştur. Edremit, Van Gölü\'nün güneyinde, Akdamar Adası\'na yakın konumu, tarihî dokusu ve doğal güzellikleriyle bilinen turistik bir ilçemizdir.\n\nKardeşlik bağımız çerçevesinde kültürel etkinlikler, gençlik programları ve sosyal projeler iki belediye işbirliği ile yürütülmektedir.',
    ),
    SisterCity(
      city: 'Güzelyurt',
      country: 'Kuzey Kıbrıs Türk Cumhuriyeti',
      description: 'En köklü kardeş şehir ilişkimiz, KKTC\'deki kardeş ilçemiz.',
      detail:
          'Çekmeköy Belde Belediyesi ile Güzelyurt Belediyesi arasında 05.07.2007 tarihinde Kardeş Şehir Protokolü imzalanmıştır. Çekmeköy Belde Belediye Meclisinin 03.09.2007 tarihli ve 2007/26 sayılı kararı ile Güzelyurt Belediye Meclisinin 08.08.2007 tarih ve 2007/17 sayılı kararları ile kardeş şehir olma kararları onaylanmıştır.\n\n13.02.2008 tarihli ve 4181/50000 sayılı İçişleri Bakanlığı Onayı ile de belediyeler arasında kardeş şehir ilişkisi kurulmuştur.',
      sisterSince: 2007,
    ),
    SisterCity(
      city: 'Vogoşça',
      country: 'Bosna-Hersek',
      description: 'Saraybosna metropoliten alanındaki kardeş belediyemiz.',
      detail:
          'Çekmeköy Belediyesi ile Vogoşça Belediyesi arasında kardeş şehir ilişkisi kurulması hakkında; Belediye Meclisimizden 08.10.2015 tarihli ve 2015/207 sayılı karar ile Vogoşça Belediyesi Meclisi\'nden 28.01.2016 tarihli ve 01-02-245/16 nolu karar alınmıştır.\n\n12.02.2016 tarihli İçişleri Bakanlığı Onayı ile iki belediye arasında kardeş şehir ilişkisi kurulması uygun görülmüştür. Belediyemizde düzenlenen imza töreni ile 15.11.2016 tarihinde Kardeş Şehir Protokolü imzalanmıştır.',
      sisterSince: 2016,
    ),
  ];

  // ───────────────────────── ÇEKMEKÖY MARKALARI ─────────────────────────
  static const brands = [
    Brand(
      name: 'Çekmeköy Belediyesi Kütüphaneleri',
      description: 'Mahallelerimizde 7\'den 70\'e tüm vatandaşlarımıza açık kütüphane ağı.',
      category: 'Eğitim',
    ),
    Brand(
      name: 'Teneffüs Dergisi',
      description: 'Çekmeköy Belediyesi\'nin gençlik dergisi.',
      category: 'Yayın',
    ),
    Brand(
      name: 'Çekmeköy Çocuk Dergisi',
      description: 'Çekmeköy çocuklarına özel periyodik yayın.',
      category: 'Yayın',
    ),
    Brand(
      name: 'Çekut',
      description: 'Çekmeköy\'ün dijital dönüşüm projesi.',
      category: 'Teknoloji',
    ),
    Brand(
      name: 'Modern Çekmeköy Model Çekmeköy',
      description: 'Şehircilik ve kent estetiği vizyon projesi.',
      category: 'Şehircilik',
    ),
    Brand(
      name: 'Açık Fikir Platformu',
      description: 'Vatandaş katılımı ve fikir paylaşım platformu.',
      category: 'Vatandaş Katılımı',
    ),
    Brand(
      name: 'Crea Centers',
      description: 'Yaratıcılık ve girişimcilik merkezi.',
      category: 'Girişimcilik',
    ),
    Brand(
      name: '100. Yıl Marşı Yarışması',
      description: 'Cumhuriyetin 100. yılına özel marş yarışması.',
      category: 'Kültür',
    ),
    Brand(
      name: '7tepe A.Ş.',
      description: 'Belediye iştiraki şirketi.',
      category: 'İştirak',
    ),
    Brand(
      name: 'Ağaç Envanteri Bilgi Sistemi',
      description: 'İlçedeki ağaçların dijital kayıt sistemi.',
      category: 'Çevre',
    ),
    Brand(
      name: 'Çekmeköy Belediyesi Dijital Arşiv',
      description: 'Belediye belge ve içeriklerinin dijital arşivi.',
      category: 'Teknoloji',
    ),
    Brand(
      name: 'Çekmeköy Uluslararası Kısa Film Yarışması',
      description: 'Uluslararası katılımlı kısa film yarışması.',
      category: 'Kültür',
    ),
    Brand(
      name: 'ÇEKPA',
      description: 'Çekmeköy Park ve Yeşil Alan İşletmeciliği.',
      category: 'İştirak',
    ),
    Brand(
      name: 'İstanbul Oyun Girişimciliği Akademisi (9999in1 Space)',
      description: 'Oyun geliştirme ve girişimcilik akademisi.',
      category: 'Girişimcilik',
    ),
    Brand(
      name: 'Ne Güzelsin Çekmeköy',
      description: 'Çekmeköy\'ün doğal güzelliklerini tanıtan proje.',
      category: 'Tanıtım',
    ),
    Brand(
      name: 'Çekmeköy Kent Lokantası',
      description: 'Vatandaşlarımıza uygun fiyatla kaliteli yemek hizmeti.',
      category: 'Sosyal Hizmet',
    ),
  ];

  // ───────────────────────── MEVZUAT ─────────────────────────
  static const regulations = [
    Regulation(title: '5393 Sayılı Belediye Kanunu', type: 'Kanun', year: '2005'),
    Regulation(title: '5216 Sayılı Büyükşehir Belediye Kanunu', type: 'Kanun', year: '2004'),
    Regulation(title: '2464 Sayılı Belediye Gelirleri Kanunu', type: 'Kanun', year: '1981'),
    Regulation(title: '4734 Sayılı Kamu İhale Kanunu', type: 'Kanun', year: '2002'),
    Regulation(title: '6098 Sayılı Türk Borçlar Kanunu', type: 'Kanun', year: '2011'),
    Regulation(title: '6698 Sayılı KVKK', type: 'Kanun', year: '2016'),
    Regulation(title: '4982 Sayılı Bilgi Edinme Hakkı Kanunu', type: 'Kanun', year: '2003'),
    Regulation(title: '3194 Sayılı İmar Kanunu', type: 'Kanun', year: '1985'),
    Regulation(title: 'Belediye Meclisi Çalışma Yönetmeliği', type: 'Yönetmelik'),
    Regulation(title: 'Belediye Encümeni Çalışma Yönetmeliği', type: 'Yönetmelik'),
    Regulation(title: 'Çekmeköy Belediyesi 2026 Bütçe Kararnamesi', type: 'Karar', year: '2026'),
    Regulation(title: 'Çekmeköy Belediyesi Disiplin Yönetmeliği', type: 'Yönetmelik'),
    Regulation(title: 'Çekmeköy Belediyesi Etik Davranış İlkeleri', type: 'Yönetmelik'),
    Regulation(title: 'Çekmeköy Belediyesi 2025-2029 Stratejik Planı', type: 'Plan', year: '2025'),
  ];

  // ───────────────────────── YAYINLARIMIZ ─────────────────────────
  static const publications = [
    Publication(
      title: 'Haftanın Özeti',
      type: 'Haftalık Bülten',
      date: 'Her Pazartesi',
      description: 'Belediyemizin haftalık faaliyetleri ve önemli gelişmeler.',
    ),
    Publication(
      title: 'Çekmeköy Belediye Bülteni',
      type: 'Aylık Dergi',
      date: 'Her ayın ilk haftası',
      description: 'Aylık etkinlikler, projeler ve sosyal hizmet duyuruları.',
    ),
    Publication(
      title: '2025 Faaliyet Raporu',
      type: 'Yıllık Rapor',
      date: 'Şubat 2026',
      description: 'Yıllık çalışmalar, mali tablolar ve performans göstergeleri.',
    ),
    Publication(
      title: '2025-2029 Stratejik Planı',
      type: 'Stratejik Plan',
      date: 'Ocak 2025',
      description: 'Beş yıllık vizyon, hedefler ve performans göstergeleri.',
    ),
    Publication(
      title: 'Çekmeköy Tarihi',
      type: 'Kitap',
      date: '2024',
      description: 'Çekmeköy\'ün tarihi süreci, mahalleleri ve kültürel mirası.',
    ),
    Publication(
      title: 'Hoş Geldin Bebek Rehberi',
      type: 'Broşür',
      date: 'Sürekli',
      description: 'Yeni anne ve babalar için belediye hizmetleri rehberi.',
    ),
  ];
}

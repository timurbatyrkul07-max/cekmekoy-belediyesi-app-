/// Akıllı varsayılanlar — API'de bilgi yokken bile her müdürlük için
/// anlamlı içerik göstermek için kullanılır.
class DepartmentDefaults {
  DepartmentDefaults._();

  static const _basePhone = '+90 (216) 600 0600';
  static const _emailDomain = 'cekmekoy.bel.tr';

  /// Müdürlük adından e-posta önekini oluşturur:
  /// "Zabıta Müdürlüğü" → "zabita"
  static String guessEmail(String unitName) {
    final map = {
      'ı': 'i', 'İ': 'i', 'i': 'i',
      'ğ': 'g', 'Ğ': 'g',
      'ü': 'u', 'Ü': 'u',
      'ş': 's', 'Ş': 's',
      'ö': 'o', 'Ö': 'o',
      'ç': 'c', 'Ç': 'c',
    };
    final buf = StringBuffer();
    for (final ch in unitName.toLowerCase().split('')) {
      buf.write(map[ch] ?? ch);
    }
    final lower = buf.toString();
    final m = RegExp(r'^([a-z]+)').firstMatch(lower);
    final prefix = m?.group(1) ?? 'iletisim';
    return '$prefix@$_emailDomain';
  }

  /// Standart belediye telefon + dahili
  static String phoneFor(String unitName) {
    final ext = _extensionFor(unitName);
    return '$_basePhone — Dahili: $ext';
  }

  static int _extensionFor(String unitName) {
    final n = unitName.toLowerCase();
    // Her müdürlük için farklı dahili (sabit hash benzeri)
    if (n.contains('zabıta')) return 3300;
    if (n.contains('fen işleri')) return 3100;
    if (n.contains('mali')) return 3200;
    if (n.contains('imar')) return 3400;
    if (n.contains('insan kaynakları')) return 3500;
    if (n.contains('bilgi işlem')) return 3600;
    if (n.contains('basın')) return 3700;
    if (n.contains('kültür')) return 3800;
    if (n.contains('gençlik') || n.contains('spor')) return 3900;
    if (n.contains('iklim') || n.contains('atık')) return 4000;
    if (n.contains('temizlik')) return 4100;
    if (n.contains('emlak')) return 4200;
    if (n.contains('plan')) return 4300;
    if (n.contains('ruhsat')) return 4400;
    if (n.contains('sosyal')) return 4500;
    if (n.contains('hukuk')) return 4600;
    if (n.contains('yazı')) return 4700;
    if (n.contains('destek')) return 4800;
    if (n.contains('strateji')) return 4900;
    if (n.contains('kentsel dönüşüm')) return 5000;
    if (n.contains('ulaşım')) return 5100;
    if (n.contains('veteriner')) return 5200;
    if (n.contains('sağlık')) return 5300;
    if (n.contains('yapı kontrol')) return 5400;
    if (n.contains('afet')) return 5500;
    if (n.contains('özel kalem')) return 1000;
    if (n.contains('teftiş') || n.contains('rehber')) return 1100;
    if (n.contains('gelirler')) return 5600;
    return 3000;
  }

  /// Müdürlüğün tipine göre standart görev/hizmet listesi
  static List<String> servicesFor(String unitName) {
    final n = unitName.toLowerCase();
    if (n.contains('zabıta')) {
      return [
        'İşyeri açma ve çalıştırma ruhsatı denetimleri',
        'Gıda ve sağlık denetimleri',
        'Kaçak yapı ve işgal kontrolleri',
        'Seyyar satıcı ve dilenci denetimi',
        'Pazaryeri düzeni ve denetimi',
        'Çevre ve gürültü denetimi',
        'Vatandaş şikayetlerinin değerlendirilmesi',
        'Tarife ücret denetimi',
      ];
    }
    if (n.contains('fen işleri')) {
      return [
        'Yol bakım, asfalt ve onarım çalışmaları',
        'Kaldırım ve bordür yapımı',
        'Yağmur suyu altyapı işleri',
        'Park, refüj, yeşil alan düzenlemesi',
        'Trafik ve sinyalizasyon hizmetleri',
        'Kentsel donatı imalatı (bank, çöp kutusu vs)',
      ];
    }
    if (n.contains('mali')) {
      return [
        'Belediye gelirlerinin tahsili',
        'Bütçe hazırlığı ve uygulaması',
        'Mali raporlama',
        'Banka hesap yönetimi',
        'İhale işlemleri mali süreci',
      ];
    }
    if (n.contains('gelirler')) {
      return [
        'Emlak vergisi tahakkuk ve tahsilat',
        'Çevre temizlik vergisi',
        'İlan, reklam ve eğlence vergileri',
        'Harç ve katılım payları',
        'Borç sorgu ve ödeme işlemleri',
      ];
    }
    if (n.contains('imar') && n.contains('şehircilik')) {
      return [
        'İmar planı uygulama ve değişiklikleri',
        'Yapı ruhsatı ve iskan belgesi',
        'İmar durumu sorgulama',
        'Numarataj ve adres tespit',
        'Kentsel tasarım çalışmaları',
      ];
    }
    if (n.contains('plan ve proje') || n.contains('plan-proje')) {
      return [
        'Stratejik plan hazırlığı ve takibi',
        'Proje üretim ve yönetimi',
        'Yatırım programı koordinasyonu',
        'Kentsel tasarım projeleri',
      ];
    }
    if (n.contains('yapı kontrol')) {
      return [
        'Yapı ruhsatı verilen inşaatların denetimi',
        'Statik ve fenni mesuliyet kontrolleri',
        'Yapı kullanma izin (iskan) süreçleri',
      ];
    }
    if (n.contains('kentsel dönüşüm')) {
      return [
        'Riskli yapı tespit ve değerlendirme',
        'Kentsel dönüşüm projeleri yönetimi',
        'Hak sahipleri ile uzlaşma süreçleri',
      ];
    }
    if (n.contains('insan kaynakları')) {
      return [
        'Personel özlük işlemleri',
        'Hizmet içi eğitim programları',
        'Performans değerlendirme',
        'Staj başvuruları ve süreçleri',
      ];
    }
    if (n.contains('bilgi işlem')) {
      return [
        'Mobil uygulama ve web sitesi yönetimi',
        'Belediye bilişim altyapısı',
        'KEOS Kent Bilgi Sistemi',
        'Veri güvenliği ve KVKK uyum',
        'E-belediye servisleri',
      ];
    }
    if (n.contains('basın')) {
      return [
        'Basın bültenleri ve duyurular',
        'Sosyal medya yönetimi',
        'Vatandaş memnuniyet anketleri',
        'Halkla ilişkiler etkinlikleri',
        'Web içerik yönetimi',
      ];
    }
    if (n.contains('kültür')) {
      return [
        'Kültür ve sanat etkinlikleri',
        'Çekmeköy Akademi kursları',
        'Tiyatro, konser, sergi organizasyonu',
        'Kütüphane hizmetleri',
        'Engelli, yaşlı ve dezavantajlı grup programları',
      ];
    }
    if (n.contains('gençlik') || n.contains('spor')) {
      return [
        'Çekmeköy Spor Okulları',
        'Yaz spor kampları',
        'Spor tesisi randevu sistemi',
        'Genç girişimci programları',
        'Bilim Merkezi etkinlikleri',
      ];
    }
    if (n.contains('iklim') || n.contains('sıfır atık')) {
      return [
        'Geri dönüşüm projeleri',
        'Sıfır atık eğitimleri',
        'İklim eylem planı çalışmaları',
        'Doğal yaşam alanları',
        'Çevre bilinci farkındalık programları',
      ];
    }
    if (n.contains('temizlik')) {
      return [
        'Şehir içi temizlik hizmetleri',
        'Çöp toplama programı',
        'Park ve cadde temizliği',
        'Atık ayrıştırma',
      ];
    }
    if (n.contains('emlak')) {
      return [
        'Belediye taşınmazlarının yönetimi',
        'Kamulaştırma işlemleri',
        'İstimlak süreçleri',
        'Tahsis ve kira işlemleri',
      ];
    }
    if (n.contains('ruhsat')) {
      return [
        'İşyeri açma ruhsatları',
        'Hafta sonu ve gece çalışma izni',
        'Ruhsat değişiklik ve devir işlemleri',
        'Sıhhi ve gayrı sıhhi müesseseler',
      ];
    }
    if (n.contains('sosyal')) {
      return [
        'Sosyal yardım programları',
        'İhtiyaç sahiplerine destek',
        'Engelli hizmetleri',
        'Yaşlı destek hizmetleri',
        'Hoş Geldin Bebek paketi',
        'Sosyal market hizmetleri',
      ];
    }
    if (n.contains('hukuk')) {
      return [
        'Belediyenin hukuki danışmanlığı',
        'Davaların takibi',
        'Sözleşme ve hukuki belge incelemeleri',
        'KVKK ve mevzuat uyumu',
      ];
    }
    if (n.contains('yazı işleri')) {
      return [
        'Meclis ve Encümen kararları',
        'Resmi yazışmalar',
        'Evrak kayıt ve takip',
        'Nikah işlemleri',
        'Bilgi edinme başvuruları',
      ];
    }
    if (n.contains('destek')) {
      return [
        'Belediye lojistik hizmetleri',
        'Araç ve ekipman bakımı',
        'Bina hizmetleri ve güvenlik',
        'Satın alma süreçleri',
      ];
    }
    if (n.contains('strateji')) {
      return [
        'Stratejik plan ve performans programları',
        'Faaliyet raporları',
        'İç kontrol ve risk yönetimi',
        'Süreç iyileştirme çalışmaları',
      ];
    }
    if (n.contains('ulaşım')) {
      return [
        'Toplu taşıma planlama desteği',
        'Servis araçları yönetimi',
        'Otopark hizmetleri',
        'Trafik düzenlemesi katkısı',
      ];
    }
    if (n.contains('veteriner')) {
      return [
        'Sokak hayvanlarının kayıt ve aşıları',
        'Kısırlaştırma operasyonları',
        'Hayvan sahiplendirme',
        'Gıda denetimi katkısı',
        'Doğal yaşam alanı yönetimi',
      ];
    }
    if (n.contains('sağlık')) {
      return [
        'Halk sağlığı eğitimleri',
        'İlk yardım hizmetleri',
        'Sağlık taramaları',
        'Çevre sağlığı denetimleri',
      ];
    }
    if (n.contains('afet')) {
      return [
        'Afet ve acil durum planları',
        'Toplanma alanları yönetimi',
        'Afet farkındalık eğitimleri',
        'Risk azaltma çalışmaları',
      ];
    }
    if (n.contains('özel kalem')) {
      return [
        'Belediye Başkanı\'nın günlük programı',
        'Protokol ilişkileri',
        'Resmi ziyaret ve karşılamalar',
        'Üst düzey yazışmalar',
      ];
    }
    if (n.contains('rehber') || n.contains('teftiş')) {
      return [
        'İdari ve mali denetim',
        'Soruşturma süreçleri',
        'Mevzuata uygunluk kontrolü',
      ];
    }
    return [
      'Belediyemizin ${unitName.replaceAll('Müdürlüğü', '').trim()} alanına ilişkin tüm hizmetler.',
      'Vatandaşlarımızın ihtiyaç ve taleplerinin değerlendirilmesi.',
      'Yasal mevzuata uygun süreç yönetimi.',
    ];
  }

  static String aboutFor(String unitName) {
    final n = unitName.toLowerCase();
    if (n.contains('zabıta')) {
      return 'Belediyemiz Zabıta Müdürlüğü, kentin düzeni, sağlığı ve esenliğini korumak amacıyla 5393 sayılı Belediye Kanunu çerçevesinde hizmet vermektedir.';
    }
    if (n.contains('fen işleri')) {
      return 'Fen İşleri Müdürlüğü olarak ilçemizdeki yol, kaldırım, asfalt ve altyapı çalışmalarını yürütüyor; kentsel altyapının modernizasyonu için projeler üretiyoruz.';
    }
    if (n.contains('mali')) {
      return 'Mali Hizmetler Müdürlüğü, belediyemizin gelir ve giderlerini titizlikle yöneten, mali şeffaflığı esas alan birimimizdir.';
    }
    return 'Çekmeköy Belediyesi $unitName olarak vatandaşlarımıza en kaliteli hizmeti sunmak için çalışmaktayız.';
  }
}

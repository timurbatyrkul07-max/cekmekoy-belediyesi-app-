import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';

class Department {
  final String name;
  final String managerName;
  final String managerTitle;
  final String description;
  final List<String> services;
  final String phone;
  final String email;
  final String address;

  const Department({
    required this.name,
    required this.managerName,
    required this.managerTitle,
    required this.description,
    required this.services,
    required this.phone,
    required this.email,
    required this.address,
  });
}

class DepartmentDetailPage extends StatelessWidget {
  final Department department;
  const DepartmentDetailPage({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: department.name,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, size: 32, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(department.managerName,
                          style: AppTextStyles.bodyBold.copyWith(color: Colors.white, fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(department.managerTitle,
                          style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Hakkında', style: AppTextStyles.bodyBold),
          const SizedBox(height: 8),
          Text(department.description,
              style: AppTextStyles.body.copyWith(height: 1.5, color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          Text('Verilen Hizmetler', style: AppTextStyles.bodyBold),
          const SizedBox(height: 8),
          ...department.services.map((s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 8),
                      decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(s, style: AppTextStyles.body.copyWith(height: 1.4))),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          Text('İletişim', style: AppTextStyles.bodyBold),
          const SizedBox(height: 12),
          _contactRow(
            icon: Icons.phone,
            label: 'Telefon',
            value: department.phone,
            onTap: () => launchUrl(
                Uri.parse('tel:${department.phone.replaceAll(RegExp(r"[^0-9+]"), "")}')),
          ),
          const SizedBox(height: 10),
          _contactRow(
            icon: Icons.mail_outline,
            label: 'E-posta',
            value: department.email,
            onTap: () => launchUrl(Uri.parse('mailto:${department.email}')),
          ),
          const SizedBox(height: 10),
          _contactRow(
            icon: Icons.location_on,
            label: 'Adres',
            value: department.address,
          ),
        ],
      ),
    );
  }

  Widget _contactRow({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.caption),
                  const SizedBox(height: 2),
                  Text(value,
                      style: AppTextStyles.bodyBold.copyWith(
                        color: onTap != null ? AppColors.primary : AppColors.textPrimary,
                      )),
                ],
              ),
            ),
            if (onTap != null) const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}

class DepartmentData {
  DepartmentData._();

  static const String _commonAddress = 'Çekmeköy Belediyesi, Merkez Mh. Piri Reis Cd. No:5 Çekmeköy/İstanbul';

  static const departments = [
    Department(
      name: 'Basın, Yayın ve Halkla İlişkiler Müdürlüğü',
      managerName: 'Mehmet ŞAHİN',
      managerTitle: 'Müdür',
      description:
          'Belediyemizin halkla ilişkilerini, basın faaliyetlerini ve dijital iletişimini yürütmektedir. Vatandaş memnuniyeti odaklı çalışmalar gerçekleştirir.',
      services: [
        'Basın bültenleri ve duyurular',
        'Sosyal medya yönetimi',
        'Vatandaş memnuniyet anketleri',
        'Halkla ilişkiler etkinlikleri',
        'Resmi protokol işlemleri',
      ],
      phone: '+90 (216) 600 0600',
      email: 'basin@cekmekoy.bel.tr',
      address: _commonAddress,
    ),
    Department(
      name: 'Mali Hizmetler Müdürlüğü',
      managerName: 'Ahmet KAYA',
      managerTitle: 'Müdür',
      description:
          'Belediyemizin gelir, gider ve bütçe işlemlerini yürütür. Vergi tahakkuk ve tahsilat işlemlerini gerçekleştirir.',
      services: [
        'Emlak vergisi işlemleri',
        'Çevre temizlik vergisi',
        'İlan ve reklam vergisi',
        'Ödeme ve tahsilat',
        'Vergi takvimi ve beyannameler',
        'e-Makbuz hizmeti',
      ],
      phone: '+90 (216) 600 0601',
      email: 'mali@cekmekoy.bel.tr',
      address: _commonAddress,
    ),
    Department(
      name: 'İmar ve Şehircilik Müdürlüğü',
      managerName: 'Fatma ÖZDEMİR',
      managerTitle: 'Müdür',
      description:
          'İlçemizdeki imar planı ve yapı denetim işlemlerini yürütür. Vatandaşlarımızın inşaat ve ruhsat süreçlerini kolaylaştırır.',
      services: [
        'Yapı ruhsatı verme',
        'İmar durumu sorgulama',
        'İskan belgesi düzenleme',
        'İmar planı tadilatları',
        'Yapı kullanma izinleri',
        'Asansör periyodik muayenesi',
      ],
      phone: '+90 (216) 600 0602',
      email: 'imar@cekmekoy.bel.tr',
      address: _commonAddress,
    ),
    Department(
      name: 'Fen İşleri Müdürlüğü',
      managerName: 'Hasan YILMAZ',
      managerTitle: 'Müdür',
      description:
          'İlçemizdeki yol, kaldırım, asfalt ve altyapı çalışmalarını yürütür. Kentsel altyapının iyileştirilmesi için çalışır.',
      services: [
        'Yol bakım ve onarım',
        'Asfalt çalışmaları',
        'Kaldırım yapımı',
        'Yağmur suyu altyapı',
        'Trafik düzenleme',
      ],
      phone: '+90 (216) 600 0603',
      email: 'fen@cekmekoy.bel.tr',
      address: _commonAddress,
    ),
    Department(
      name: 'Kültür, Sanat ve Sosyal İşler Müdürlüğü',
      managerName: 'Ayşe DEMİR',
      managerTitle: 'Müdür',
      description:
          'Çekmeköy Akademi, sanat etkinlikleri, sosyal yardımlar ve kültürel projeleri organize eder.',
      services: [
        'Çekmeköy Akademi kursları',
        'Tiyatro ve konser etkinlikleri',
        'Sosyal yardım programları',
        'Engelli hizmetleri',
        'Hoş geldin bebek paketi',
        'Yaşlı dostu uygulamalar',
      ],
      phone: '+90 (216) 600 0604',
      email: 'kultur@cekmekoy.bel.tr',
      address: _commonAddress,
    ),
    Department(
      name: 'Gençlik ve Spor Hizmetleri Müdürlüğü',
      managerName: 'Mustafa ARSLAN',
      managerTitle: 'Müdür',
      description:
          'Gençlerimize yönelik spor okulları, yaz kampları ve sosyal aktiviteleri düzenler.',
      services: [
        'Çekmeköy Spor Okulları',
        'Yaz spor kampları',
        'Spor tesisi randevu',
        'Genç girişimci programları',
        'Bilim merkezi etkinlikleri',
      ],
      phone: '+90 (216) 600 0605',
      email: 'genclik@cekmekoy.bel.tr',
      address: _commonAddress,
    ),
    Department(
      name: 'Zabıta Müdürlüğü',
      managerName: 'Ömer TÜRK',
      managerTitle: 'Müdür',
      description:
          'Belediye düzeninin sağlanması, kaçak yapı, gıda denetimi ve seyyar satıcı kontrolü gibi görevleri yürütür.',
      services: [
        'İşyeri açma ruhsatı denetimi',
        'Gıda ve sağlık denetimleri',
        'Kaçak yapı kontrolleri',
        'Seyyar satıcı denetimi',
        'Pazaryeri düzeni',
        'Şikayet değerlendirme',
      ],
      phone: '+90 (216) 600 0606',
      email: 'zabita@cekmekoy.bel.tr',
      address: _commonAddress,
    ),
    Department(
      name: 'İklim Değişikliği ve Sıfır Atık Müdürlüğü',
      managerName: 'Zeynep KAR',
      managerTitle: 'Müdür',
      description:
          'Çevre koruma, geri dönüşüm ve sıfır atık projelerini yürütür. Çekmeköy\'ün yeşil bir şehir olması için çalışır.',
      services: [
        'Geri dönüşüm projeleri',
        'Çevre temizliği',
        'Atık toplama programı',
        'Sıfır atık eğitimleri',
        'İklim eylem planı',
        'Doğal yaşam alanları',
      ],
      phone: '+90 (216) 600 0607',
      email: 'cevre@cekmekoy.bel.tr',
      address: _commonAddress,
    ),
    Department(
      name: 'İnsan Kaynakları ve Eğitim Müdürlüğü',
      managerName: 'Selin AYDIN',
      managerTitle: 'Müdür',
      description:
          'Belediye personelinin özlük işleri, eğitim ve gelişim programlarını yürütür.',
      services: [
        'Personel özlük işlemleri',
        'Hizmet içi eğitim',
        'Staj başvuruları',
        'Performans değerlendirme',
      ],
      phone: '+90 (216) 600 0608',
      email: 'ik@cekmekoy.bel.tr',
      address: _commonAddress,
    ),
    Department(
      name: 'Bilgi İşlem Müdürlüğü',
      managerName: 'Emre AKSOY',
      managerTitle: 'Müdür',
      description:
          'Belediyemizin tüm bilişim altyapısını, dijital hizmetlerini ve veri güvenliğini sağlar.',
      services: [
        'Mobil uygulama geliştirme',
        'Web sitesi yönetimi',
        'KEOS Kent Rehberi',
        'Bilgi güvenliği',
        'Veri analizi',
      ],
      phone: '+90 (216) 600 0609',
      email: 'bilgiislem@cekmekoy.bel.tr',
      address: _commonAddress,
    ),
  ];

  static Department? findByName(String name) {
    try {
      return departments.firstWhere((d) => d.name == name);
    } catch (_) {
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';

class _Standard {
  final String code;
  final String name;
  final String body;
  final IconData icon;
  final Color color;
  final List<String> principles;

  const _Standard({
    required this.code,
    required this.name,
    required this.body,
    required this.icon,
    required this.color,
    required this.principles,
  });
}

class EysPage extends StatelessWidget {
  const EysPage({super.key});

  static const _standards = [
    _Standard(
      code: 'ISO 9001',
      name: 'Kalite Yönetim Sistemi',
      body:
          'Çekmeköy Belediyesi olarak, vatandaşlarımıza sunduğumuz hizmetlerin kalitesini sürekli iyileştirmek ve yüksek vatandaş memnuniyetini sağlamak amacıyla ISO 9001 Kalite Yönetim Sistemi standardını uygulamaktayız.',
      icon: Icons.verified,
      color: AppColors.primary,
      principles: [
        'Vatandaş odaklı yaklaşım',
        'Liderlik ve hesap verebilirlik',
        'Süreçlerin etkin yönetimi',
        'Sürekli iyileştirme',
        'Kanıta dayalı karar alma',
      ],
    ),
    _Standard(
      code: 'ISO 14001',
      name: 'Çevre Yönetim Sistemi',
      body:
          'Çekmeköy\'ün yeşil ve doğal güzelliklerini gelecek nesillere aktarmak için çevre koruma odaklı politikalar yürütüyoruz. ISO 14001 standardı, çevresel etkilerimizi sistematik olarak yönetmemizi sağlar.',
      icon: Icons.eco,
      color: Color(0xFF10B981),
      principles: [
        'Çevresel etkilerin azaltılması',
        'Sıfır atık yaklaşımı',
        'Yeşil alanların korunması',
        'Sürdürülebilir kaynak kullanımı',
        'İklim eylem planı',
      ],
    ),
    _Standard(
      code: 'ISO 45001',
      name: 'İş Sağlığı ve Güvenliği Yönetim Sistemi',
      body:
          'Belediyemiz çalışanlarının ve hizmet alan vatandaşlarımızın sağlık ve güvenliğini ön planda tutuyor; iş kazalarını önlemek için ISO 45001 standardı ile risk değerlendirmesi yapıyoruz.',
      icon: Icons.health_and_safety,
      color: AppColors.accent,
      principles: [
        'Risk değerlendirmesi ve azaltma',
        'Çalışan katılımı',
        'Acil durum hazırlığı',
        'Yasal uyumluluk',
        'Sürekli eğitim ve farkındalık',
      ],
    ),
    _Standard(
      code: 'ISO 27001',
      name: 'Bilgi Güvenliği Yönetim Sistemi',
      body:
          'Vatandaş ve kurum verilerinin gizliliğini, bütünlüğünü ve erişilebilirliğini ISO 27001 Bilgi Güvenliği Yönetim Sistemi standardı çerçevesinde sağlıyoruz. KVKK ile uyumlu, güvenli dijital hizmetler sunuyoruz.',
      icon: Icons.security,
      color: AppColors.primaryLight,
      principles: [
        'Veri gizliliği ve korunması',
        'Erişim yönetimi',
        'Olay müdahale planları',
        'Düzenli denetim ve gözden geçirme',
        'KVKK uyum süreçleri',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Entegre Yönetim Sistemi',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          _hero(),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Çekmeköy Belediyesi olarak hizmet kalitemizi uluslararası standartlarla taçlandırmak amacıyla 4 farklı yönetim sistemi standardını entegre olarak uygulamaktayız. Bu standartlar bir bütün halinde "Entegre Yönetim Sistemi" (EYS) olarak adlandırılır.',
              style: AppTextStyles.body.copyWith(height: 1.5, fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          Text('STANDARTLARIMIZ', style: AppTextStyles.sectionLabel),
          const SizedBox(height: 12),
          ..._standards.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _StandardCard(standard: s),
              )),
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.workspace_premium, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('EYS',
                    style: AppTextStyles.h3.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    )),
                Text(
                  'Entegre Yönetim Sistemi',
                  style: AppTextStyles.caption.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StandardCard extends StatelessWidget {
  final _Standard standard;
  const _StandardCard({required this.standard});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => _StandardDetailPage(standard: standard)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: standard.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(standard.icon, color: standard.color, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: standard.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        standard.code,
                        style: AppTextStyles.caption.copyWith(
                          color: standard.color,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(standard.name, style: AppTextStyles.bodyBold),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}

class _StandardDetailPage extends StatelessWidget {
  final _Standard standard;
  const _StandardDetailPage({required this.standard});

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: standard.code,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: standard.color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border(left: BorderSide(color: standard.color, width: 5)),
            ),
            child: Row(
              children: [
                Icon(standard.icon, color: standard.color, size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(standard.code,
                          style: AppTextStyles.h2.copyWith(color: standard.color)),
                      Text(standard.name,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Hakkında', style: AppTextStyles.bodyBold),
          const SizedBox(height: 8),
          Text(standard.body,
              style: AppTextStyles.body.copyWith(height: 1.6, fontSize: 14)),
          const SizedBox(height: 24),
          Text('TEMEL İLKELERİMİZ', style: AppTextStyles.sectionLabel),
          const SizedBox(height: 10),
          ...standard.principles.map((p) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 7),
                      decoration: BoxDecoration(
                        color: standard.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(p,
                          style: AppTextStyles.body.copyWith(height: 1.5)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

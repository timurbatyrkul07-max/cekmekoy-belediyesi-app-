import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';

class _Policy {
  final String title;
  final String body;
  final IconData icon;
  const _Policy(this.title, this.body, this.icon);
}

class PoliciesPage extends StatelessWidget {
  const PoliciesPage({super.key});

  static const _policies = [
    _Policy(
      'Kalite Politikası',
      'Vatandaş memnuniyetini esas alan, sürekli iyileşme ve süreç yönetimi anlayışıyla kaliteli hizmet sunarız.',
      Icons.verified,
    ),
    _Policy(
      'Çevre Politikası',
      'Çekmeköy\'ün doğal güzelliklerini koruyan, sürdürülebilir ve sıfır atık ilkesini benimseyen bir yönetim sergileriz.',
      Icons.eco,
    ),
    _Policy(
      'Bilgi Güvenliği Politikası',
      'Vatandaş ve kurum verilerinin gizliliği, bütünlüğü ve erişilebilirliğini ISO 27001 standardı ile sağlarız.',
      Icons.security,
    ),
    _Policy(
      'İş Sağlığı ve Güvenliği Politikası',
      'Tüm çalışanlarımız ve hizmet alan vatandaşlarımız için güvenli iş ortamı ve sağlıklı çalışma şartları sağlarız.',
      Icons.health_and_safety,
    ),
    _Policy(
      'Sosyal Sorumluluk Politikası',
      'İhtiyaç sahibi her bireye eşit, erişilebilir ve onurlu bir hizmet sunmayı taahhüt ederiz.',
      Icons.diversity_3,
    ),
    _Policy(
      'Şeffaflık ve Hesap Verebilirlik',
      'Tüm karar süreçlerimizde şeffaf, açıklanabilir ve denetlenebilir bir yönetim anlayışı benimseriz.',
      Icons.visibility,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Politikalarımız',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: _policies
            .map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _PolicyCard(policy: p),
                ))
            .toList(),
      ),
    );
  }
}

class _PolicyCard extends StatelessWidget {
  final _Policy policy;
  const _PolicyCard({required this.policy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(policy.icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(policy.title, style: AppTextStyles.bodyBold),
                const SizedBox(height: 4),
                Text(policy.body,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

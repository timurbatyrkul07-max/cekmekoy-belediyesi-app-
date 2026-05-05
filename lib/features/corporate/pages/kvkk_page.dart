import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../../webview/web_view_page.dart';

class _KvkkDoc {
  final String title;
  final String slug;
  final IconData icon;
  final String description;
  const _KvkkDoc({
    required this.title,
    required this.slug,
    required this.icon,
    required this.description,
  });

  String get url => 'https://www.cekmekoy.bel.tr/icerik/kurumsal/$slug';
}

class KvkkPage extends StatelessWidget {
  const KvkkPage({super.key});

  static const _docs = [
    _KvkkDoc(
      title: 'Gizlilik Bildirimi',
      slug: 'gizlilik-bildirimi',
      icon: Icons.privacy_tip,
      description: 'Genel gizlilik bildirim metni',
    ),
    _KvkkDoc(
      title: 'KVKK Aydınlatma Metni',
      slug: 'kvkk-aydinlatma-metni',
      icon: Icons.shield_outlined,
      description: '6698 sayılı Kanun kapsamında genel aydınlatma metni',
    ),
    _KvkkDoc(
      title: 'KVKK Açık Rıza Beyanı',
      slug: 'kvkk-acik-riza-beyani',
      icon: Icons.check_circle_outline,
      description: 'Açık rıza gerektiren işlemler için beyan metni',
    ),
    _KvkkDoc(
      title: 'KVKK Başvuru Formu',
      slug: 'kvkk-basvuru-formu',
      icon: Icons.assignment,
      description: 'Veri sahibi haklarınızı kullanmak için başvuru formu',
    ),
    _KvkkDoc(
      title: 'Çerez Politikası',
      slug: 'cerez-politikasi',
      icon: Icons.cookie,
      description: 'Çerez kullanım politikası',
    ),
    _KvkkDoc(
      title: 'Vatandaşlar için Bilgi Güvenliği Politikası',
      slug: 'vatandaslar-icin-bilgi-guvenligi-politikasi',
      icon: Icons.security,
      description: 'Bilgi güvenliği yönetim ilkeleri',
    ),
    _KvkkDoc(
      title: 'E-Belediye Aydınlatma Metni',
      slug: 'e-belediye-aydinlatma-metni',
      icon: Icons.account_balance,
      description: 'E-belediye hizmetlerinde veri işleme',
    ),
    _KvkkDoc(
      title: 'E-Bülten ve SMS Aydınlatma Metni',
      slug: 'e-bulten-ve-sms-uyeligine-yonelik-aydinlatma-metni',
      icon: Icons.mark_email_read,
      description: 'E-bülten ve SMS üyeliği için bilgilendirme',
    ),
    _KvkkDoc(
      title: 'SMS KVKK Aydınlatma Metni',
      slug: 'sms-kvkk-aydinlatma-metni',
      icon: Icons.sms,
      description: 'SMS gönderim sürecine yönelik bilgilendirme',
    ),
    _KvkkDoc(
      title: 'Seri Nokta Başvuru Aydınlatma Metni',
      slug: 'seri-nokta-basvuru-alani-aydinlatma-metni',
      icon: Icons.location_on,
      description: 'Talep ve şikayet sistemi (Seri Nokta) için',
    ),
    _KvkkDoc(
      title: 'Çekmeköy Akademi KVKK Aydınlatma Metni',
      slug: 'cekmekoy-akademi-kvkk-aydinlatma-metni',
      icon: Icons.school,
      description: 'Akademi kursları ve eğitim hizmetleri için',
    ),
    _KvkkDoc(
      title: 'Çekmeköy Akademi Açık Rıza Metni',
      slug: 'cekmekoy-akademi-acik-riza-metni',
      icon: Icons.school_outlined,
      description: 'Akademi için açık rıza beyanı',
    ),
    _KvkkDoc(
      title: 'Crea Centers KVKK Aydınlatma Metni',
      slug: 'crea-s-kvkk-aydinlatma-metni',
      icon: Icons.business,
      description: 'Crea Centers hizmetleri için bilgilendirme',
    ),
    _KvkkDoc(
      title: 'İstanbul Kart Desteği Aydınlatma Metni',
      slug: 'istanbul-kart-destegi-aydinlatma-metni',
      icon: Icons.credit_card,
      description: 'İstanbul Kart desteği veri işleme',
    ),
    _KvkkDoc(
      title: 'İstanbul Kart Desteği Açık Rıza Metni',
      slug: 'istanbul-kart-destegi-acik-riza-metni',
      icon: Icons.credit_card_outlined,
      description: 'İstanbul Kart desteği için açık rıza',
    ),
    _KvkkDoc(
      title: 'Dijital Kütüphane Üyelik Sözleşmesi',
      slug: 'digital-kutuphane-uyelik-sozlesmesi',
      icon: Icons.menu_book,
      description: 'Dijital kütüphane kullanım koşulları',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'KVKK',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          _hero(),
          const SizedBox(height: 20),
          _intro(),
          const SizedBox(height: 24),
          Text('AYDINLATMA METİNLERİ', style: AppTextStyles.sectionLabel),
          const SizedBox(height: 12),
          ..._docs.map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _DocTile(doc: d),
              )),
          const SizedBox(height: 24),
          _contactCard(),
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
            child: const Icon(Icons.shield_outlined, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('6698 SAYILI KANUN',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white70,
                      fontSize: 10,
                      letterSpacing: 1,
                    )),
                const SizedBox(height: 2),
                Text(
                  'Kişisel Verilerin\nKorunması Kanunu',
                  style: AppTextStyles.h3.copyWith(color: Colors.white, height: 1.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _intro() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Çekmeköy Belediyesi olarak kişisel verilerinizi 6698 sayılı Kişisel Verilerin Korunması Kanunu kapsamında işlemekteyiz. Aşağıda hizmet alanlarına özel aydınlatma metinlerimize ulaşabilirsiniz.',
            style: AppTextStyles.body.copyWith(height: 1.5, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _contactCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: AppColors.accent, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.contact_mail, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              Text('KVKK Başvurularınız İçin', style: AppTextStyles.bodyBold),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () => launchUrl(Uri.parse('mailto:kvkk@cekmekoy.bel.tr')),
            child: Row(
              children: [
                const Icon(Icons.mail_outline, size: 16, color: AppColors.accent),
                const SizedBox(width: 8),
                Text('kvkk@cekmekoy.bel.tr',
                    style: AppTextStyles.bodyBold.copyWith(color: AppColors.accent)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: () => launchUrl(Uri.parse('tel:+902166000600')),
            child: Row(
              children: [
                const Icon(Icons.phone, size: 16, color: AppColors.accent),
                const SizedBox(width: 8),
                Text('+90 (216) 600 0600',
                    style: AppTextStyles.bodyBold.copyWith(color: AppColors.accent)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocTile extends StatelessWidget {
  final _KvkkDoc doc;
  const _DocTile({required this.doc});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => WebViewPage(title: doc.title, url: doc.url),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(doc.icon, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doc.title, style: AppTextStyles.bodyBold),
                    const SizedBox(height: 2),
                    Text(doc.description,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        )),
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

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';

class VisionMissionPage extends StatelessWidget {
  const VisionMissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Vizyon ve Misyon',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _block(
            icon: Icons.visibility,
            color: AppColors.primary,
            title: 'VİZYONUMUZ',
            body:
                'Doğal güzellikleri, yeşil dokusu ve örnek belediyecilik anlayışıyla; hemşehrilerinin mutlu, huzurlu ve gönençli bir yaşam sürdüğü, sürdürülebilir kalkınma ilkesiyle yönetilen, marka değeri yüksek, çağdaş, yaşanabilir bir Çekmeköy.',
          ),
          const SizedBox(height: 16),
          _block(
            icon: Icons.flag,
            color: AppColors.accent,
            title: 'MİSYONUMUZ',
            body:
                'Çekmeköy halkının yaşam kalitesini artırmak; katılımcı, şeffaf, hesap verebilir, çevreye duyarlı ve insan odaklı belediyecilik anlayışıyla; eğitim, kültür, sosyal hizmet ve modern altyapı projelerini hayata geçirerek hemşehrilerimize en iyi hizmeti sunmak.',
          ),
          const SizedBox(height: 16),
          _block(
            icon: Icons.diamond_outlined,
            color: AppColors.primary,
            title: 'TEMEL DEĞERLERİMİZ',
            body: '',
            extras: const [
              '• Şeffaflık ve Hesap Verebilirlik',
              '• Vatandaş Memnuniyeti Odaklı Hizmet',
              '• Sosyal Belediyecilik',
              '• Çevreye Saygı ve Sürdürülebilirlik',
              '• Katılımcı Yönetim',
              '• Etik Değerlere Bağlılık',
              '• Yenilikçilik ve Teknoloji Kullanımı',
              '• Eşitlik ve Adalet',
            ],
          ),
        ],
      ),
    );
  }

  Widget _block({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
    List<String> extras = const [],
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Text(title,
                  style: AppTextStyles.bodyBold.copyWith(
                    color: color,
                    letterSpacing: 0.5,
                  )),
            ],
          ),
          if (body.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(body, style: AppTextStyles.body.copyWith(height: 1.6, fontSize: 15)),
          ],
          if (extras.isNotEmpty) ...[
            const SizedBox(height: 14),
            ...extras.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(e,
                      style: AppTextStyles.body.copyWith(height: 1.5, fontSize: 14)),
                )),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';

class MayorMessagePage extends StatelessWidget {
  const MayorMessagePage({super.key});

  static const _quote =
      'Çekmeköy\'ün her bir vatandaşı için, bu güzel ilçemizi daha yaşanabilir, daha yeşil ve daha modern bir hâle getirmek için durmadan çalışıyoruz.';

  static const _body = '''Değerli Çekmeköylü Hemşehrim,

İlçemizin geleceğini birlikte inşa etme yolculuğunda bize gösterdiğiniz teveccüh ve güven için her birinize teşekkür ediyorum. 31 Mart 2024 yerel seçimlerinde Çekmeköy tarihindeki en yüksek oy oranıyla göreve gelmek hayatımın en anlamlı sorumluluğu oldu.

Belediyecilik bizim için sadece hizmet üretmek değil, vatandaşımızın yanında olmak, sorunlarını çözüm odaklı bir anlayışla ele almak ve şehrimizi gelecek nesillere daha iyi bir hâlde devretmektir. Bu anlayışla; sosyal belediyecilik, çevreci belediyecilik, şeffaf yönetim ve katılımcı demokrasi ilkeleriyle çalışmaktayız.

Çekmeköy Kent Lokantası, Çekmeköy Akademi, doğal yaşam alanları ve gençliğimize yönelik akademiler gibi projelerimizle hemşehrilerimizin hayatında somut bir fark yaratmayı hedefliyoruz. Tüm bu çalışmaları sizin destek ve önerilerinizle daha da ileriye taşıyoruz.

Belediyemizin kapısı, telefonu ve mobil uygulaması her zaman size açıktır. Talep, öneri, eleştiri ve teşekkürlerinizi bekliyor; her birinize tek tek ulaşmaya çalışıyorum.

Saygı ve sevgilerimle,
Orhan ÇERKEZ
Çekmeköy Belediye Başkanı''';

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Başkanın Mesajı',
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            color: AppColors.primary,
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(AppStrings.mayorPhoto, width: 64, height: 64, fit: BoxFit.cover),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.mayorName,
                          style: AppTextStyles.bodyBold.copyWith(color: Colors.white, fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(AppStrings.mayorTitle,
                          style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(color: AppColors.accent, width: 4),
                    ),
                  ),
                  child: Text(
                    '"$_quote"',
                    style: AppTextStyles.body.copyWith(
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(_body,
                    style: AppTextStyles.body.copyWith(height: 1.7, fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

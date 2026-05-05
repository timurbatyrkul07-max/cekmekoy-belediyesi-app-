import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/branded_scaffold.dart';
import '../data/corporate_data.dart';
import '../widgets/person_card.dart';
import 'person_detail_page.dart';

class EthicsCommitteePage extends StatelessWidget {
  const EthicsCommitteePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BrandedScaffold(
      title: 'Etik Komisyonu',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border(left: BorderSide(color: AppColors.accent, width: 4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Etik İlkelerimiz', style: AppTextStyles.bodyBold),
                const SizedBox(height: 8),
                Text(
                  'Belediyemiz, kamu hizmetinde dürüstlük, şeffaflık, hesap verebilirlik ve eşitlik ilkeleri çerçevesinde çalışır. 5176 sayılı Kanun kapsamında oluşturulan Etik Komisyonumuz, personelin etik davranış ilkelerine uyumunu denetler ve eğitim faaliyetlerini yürütür.',
                  style: AppTextStyles.body.copyWith(height: 1.5, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Komisyon Üyeleri', style: AppTextStyles.bodyBold),
          const SizedBox(height: 12),
          ...CorporateData.ethicsCommittee.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: PersonCard(
                  person: p,
                  detailed: false,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PersonDetailPage(person: p)),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

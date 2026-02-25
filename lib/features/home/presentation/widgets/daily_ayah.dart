import 'package:flutter/material.dart';
import 'package:hajj_app/core/constants/app_colors.dart';

import '../../../../shared/widgets/custom_text.dart';

class DailyAyah extends StatelessWidget {
  const DailyAyah({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [cs.surfaceDim, cs.brandGold],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: cs.surfaceDim.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          CustomText(
            '"وَأَتِمُّوا الْحَجَّ وَالْعُمْرَةَ لِلَّهِ"',
            type: CustomTextType.bodyLarge,
            color: CustomTextColor.red,
            textAlign: TextAlign.center,
          ),
          CustomText(
            'سورة البقرة - آية 196',
            type: CustomTextType.labelLarge,
            color: CustomTextColor.red,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

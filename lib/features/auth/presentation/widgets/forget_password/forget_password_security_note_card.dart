import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../../shared/widgets/custom_container.dart';

class ForgetPasswordSecurityNoteCard extends StatelessWidget {
  const ForgetPasswordSecurityNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      gradientColors: [cs.surfaceDim, cs.brandGold],
      borderRadius: 12,
      borderWidth: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(LucideIcons.info, size: 17, color: cs.error),
              const SizedBox(width: 4),
              const CustomText(
                'auth.forget.security_note_title',
                type: CustomTextType.titleSmall,
                color: CustomTextColor.red,
              ),
            ],
          ),
          const SizedBox(height: 4),
          const CustomText(
            'auth.forget.security_note_body',
            type: CustomTextType.bodySmall,
            color: CustomTextColor.lightRed,
          ),
        ],
      ),
    );
  }
}

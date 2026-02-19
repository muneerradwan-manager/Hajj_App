import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/shared/widgets/custom_text.dart';

class ForgetPasswordSecurityNoteCard extends StatelessWidget {
  const ForgetPasswordSecurityNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            cs.secondaryContainer.withValues(alpha: 0.95),
            cs.secondaryContainer.withValues(alpha: 0.75),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
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

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';

class ForgetPasswordSecurityNoteCard extends StatelessWidget {
  const ForgetPasswordSecurityNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
              Text(
                'auth.forget.security_note_title'.tr(context),
                style: textTheme.titleSmall?.copyWith(color: cs.error),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'auth.forget.security_note_body'.tr(context),
            style: textTheme.bodySmall?.copyWith(
              color: cs.error.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

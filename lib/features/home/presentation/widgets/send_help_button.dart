import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/features/home/presentation/widgets/send_help_dialog.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';

class SendHelpButton extends StatelessWidget {
  const SendHelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () async {
        final success = await showSendHelpDialog(context);
        if (success == true && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('home.help_dialog_success'.tr(context)),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [cs.brandRed, cs.brandRedAlt],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: cs.brandRed.withValues(alpha: 0.5),
              blurRadius: 1,
              offset: const Offset(0, 0.5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          spacing: 10,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: cs.brandRed.withValues(alpha: 0.5),
                    blurRadius: 1,
                    offset: const Offset(0, 0.5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                LucideIcons.mapPin,
                color: AppColors.white,
                size: 20,
              ),
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'home.help_title',
                    type: CustomTextType.bodyLarge,
                    color: CustomTextColor.white,
                  ),
                  CustomText(
                    'home.help_subtitle',
                    type: CustomTextType.labelSmall,
                    color: CustomTextColor.white,
                  ),
                ],
              ),
            ),
            Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

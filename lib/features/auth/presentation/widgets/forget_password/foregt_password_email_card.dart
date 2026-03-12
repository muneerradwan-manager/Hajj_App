import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/shared/widgets/app_card_container.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/gradient_elevated_button.dart';

class ForgetPasswordEmailCard extends StatelessWidget {
  const ForgetPasswordEmailCard({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.decoration,
    required this.validateEmail,
    required this.onSend,
    this.isLoading = false,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final InputDecoration decoration;
  final String? Function(String?) validateEmail;
  final VoidCallback? onSend;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppCardContainer(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomContainer(
              gradientColors: [cs.primaryContainer, cs.primary],
              borderRadius: 100,
              borderWidth: 1,
              child: const Icon(LucideIcons.mail, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const CustomText(
              'auth.forget.email_card_title',
              textAlign: TextAlign.center,
              type: CustomTextType.titleLarge,
              color: CustomTextColor.red,
            ),
            const SizedBox(height: 6),
            const CustomText(
              'auth.forget.email_card_subtitle',
              textAlign: TextAlign.center,
              type: CustomTextType.bodyMedium,
              color: CustomTextColor.gold,
            ),
            const SizedBox(height: 24),
            const CustomText(
              'auth.forget.email_label',
              textAlign: TextAlign.start,
              type: CustomTextType.titleSmall,
              color: CustomTextColor.red,
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: TextStyle(color: cs.brandRed),
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: decoration.copyWith(
                hintStyle: TextStyle(
                  color: cs.errorContainer.withValues(alpha: .2),
                ),
              ),
              validator: validateEmail,
            ),
            const SizedBox(height: 20),
            GradientElevatedButton(
              gradientColor: GradientColors.green,
              onPressed: isLoading ? null : onSend,
              icon: isLoading
                  ? const SizedBox.shrink()
                  : Icon(LucideIcons.send, size: 18, color: cs.onPrimary),
              child: isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: cs.onPrimary,
                      ),
                    )
                  : const CustomText(
                      'auth.forget.send_button',
                      type: CustomTextType.titleMedium,
                      color: CustomTextColor.white,
                    ),
            ),
            const SizedBox(height: 20),
            const CustomText(
              'auth.forget.send_helper',
              textAlign: TextAlign.center,
              type: CustomTextType.bodySmall,
              color: CustomTextColor.hint,
            ),
          ],
        ),
      ),
    );
  }
}

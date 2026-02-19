import 'package:flutter/material.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';

class RegisterReviewDataCard extends StatelessWidget {
  const RegisterReviewDataCard({
    super.key,
    required this.formKey,
    required this.data,
    required this.onSend,
    required this.onBack,
  });

  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> data;
  final VoidCallback? onSend;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    String valueOrFallback(String key, String fallbackKey) {
      final raw = data[key];
      if (raw is String && raw.trim().isNotEmpty) {
        return raw.trim();
      }
      return fallbackKey.tr(context);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: cs.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: cs.shadow.withValues(alpha: 0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(LucideIcons.check, color: cs.onPrimary, size: 30),
              ),
            ),
            const SizedBox(height: 12),
            const CustomText(
              'auth.register.review_title',
              textAlign: TextAlign.center,
              type: CustomTextType.titleLarge,
              color: CustomTextColor.green,
            ),
            const SizedBox(height: 6),
            const CustomText(
              'auth.register.review_subtitle',
              textAlign: TextAlign.center,
              type: CustomTextType.bodyMedium,
              color: CustomTextColor.lightGreen,
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: cs.surfaceDim),
                color: cs.surfaceDim.withValues(
                  alpha: .2,
                ), // Color(0xffF9F8F6),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        LucideIcons.mail,
                        color: cs.primary.withValues(alpha: 0.7),
                      ),
                      const CustomText(
                        'auth.register.review_email_label',
                        type: CustomTextType.bodySmall,
                        color: CustomTextColor.gold,
                      ),
                    ],
                  ),
                  CustomText(
                    valueOrFallback(
                      'email',
                      'auth.register.review_placeholder_email',
                    ),
                    type: CustomTextType.bodyLarge,
                    color: CustomTextColor.green,
                    translate: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: cs.surfaceDim),
                color: cs.surfaceDim.withValues(
                  alpha: .2,
                ), // Color(0xffF9F8F6),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        LucideIcons.user,
                        color: cs.primary.withValues(alpha: 0.7),
                      ),
                      const CustomText(
                        'auth.register.review_national_id_label',
                        type: CustomTextType.bodySmall,
                        color: CustomTextColor.gold,
                      ),
                    ],
                  ),
                  CustomText(
                    valueOrFallback(
                      'nationalId',
                      'auth.register.review_placeholder_national_id',
                    ),
                    type: CustomTextType.bodyLarge,
                    color: CustomTextColor.green,
                    translate: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: cs.surfaceDim),
                color: cs.surfaceDim.withValues(
                  alpha: .2,
                ), // Color(0xffF9F8F6),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        LucideIcons.phone,
                        color: cs.primary.withValues(alpha: 0.7),
                      ),
                      const CustomText(
                        'auth.register.review_phone_label',
                        type: CustomTextType.bodySmall,
                        color: CustomTextColor.gold,
                      ),
                    ],
                  ),
                  CustomText(
                    valueOrFallback(
                      'phone',
                      'auth.register.review_placeholder_phone',
                    ),
                    type: CustomTextType.bodyLarge,
                    color: CustomTextColor.green,
                    translate: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: cs.surfaceDim),
                color: cs.surfaceDim.withValues(
                  alpha: .2,
                ), // Color(0xffF9F8F6),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(15),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        LucideIcons.barcode,
                        color: cs.primary.withValues(alpha: 0.7),
                      ),
                      const CustomText(
                        'auth.register.review_barcode_label',
                        type: CustomTextType.bodySmall,
                        color: CustomTextColor.gold,
                      ),
                    ],
                  ),
                  CustomText(
                    valueOrFallback(
                      'barcode',
                      'auth.register.review_placeholder_barcode',
                    ),
                    type: CustomTextType.bodyLarge,
                    color: CustomTextColor.green,
                    translate: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: cs.surfaceDim),
                color: cs.surfaceDim.withValues(
                  alpha: .2,
                ), // Color(0xffF9F8F6),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            LucideIcons.lock,
                            color: cs.primary.withValues(alpha: 0.7),
                          ),
                          const CustomText(
                            'auth.register.review_password_label',
                            type: CustomTextType.bodySmall,
                            color: CustomTextColor.gold,
                          ),
                        ],
                      ),
                      CustomText(
                        valueOrFallback(
                          'password',
                          'auth.register.review_placeholder_password',
                        ),
                        type: CustomTextType.bodyLarge,
                        color: CustomTextColor.green,
                        translate: false,
                      ),
                    ],
                  ),
                  Icon(
                    LucideIcons.eye,
                    color: cs.primary.withValues(alpha: 0.7),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'auth.register.review_warning_label'.tr(context),
                      style: textTheme.titleSmall?.copyWith(color: cs.primary),
                    ),
                    TextSpan(
                      text: 'auth.register.review_warning_body'.tr(context),
                      style: textTheme.bodySmall?.copyWith(color: cs.primary),
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onSend,
                    child: CustomText(
                      'auth.register.create_account_button',
                      type: CustomTextType.titleMedium,
                      style: textTheme.titleMedium?.copyWith(
                        color: cs.onPrimary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: cs.primary),
                    ),
                    onPressed: onBack,
                    child: const CustomText(
                      'auth.register.back_button',
                      type: CustomTextType.titleMedium,
                      color: CustomTextColor.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

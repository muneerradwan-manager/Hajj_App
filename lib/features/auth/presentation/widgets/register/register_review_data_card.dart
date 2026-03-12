import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/localization/app_localizations_setup.dart';
import 'package:bawabatelhajj/shared/widgets/app_card_container.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:bawabatelhajj/shared/widgets/important_note_box.dart';
import 'package:bawabatelhajj/shared/widgets/info_display_tile.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/gradient_elevated_button.dart';

class RegisterReviewDataCard extends StatefulWidget {
  const RegisterReviewDataCard({
    super.key,
    required this.formKey,
    required this.email,
    required this.nationalId,
    required this.phone,
    required this.barcode,
    required this.password,
    required this.onSend,
    required this.onBack,
  });

  final GlobalKey<FormState> formKey;
  final String email;
  final String nationalId;
  final String phone;
  final String barcode;
  final String password;
  final VoidCallback? onSend;
  final VoidCallback? onBack;

  @override
  State<RegisterReviewDataCard> createState() => _RegisterReviewDataCardState();
}

class _RegisterReviewDataCardState extends State<RegisterReviewDataCard> {
  bool _isPasswordVisible = false;

  String _maskedPassword(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return '';
    return '*' * normalized.length;
  }

  String _valueOrFallback(String value, String fallbackKey) {
    final normalized = value.trim();
    if (normalized.isNotEmpty) return normalized;
    return fallbackKey.tr(context);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppCardContainer(
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            CustomContainer(
              gradientColors: [cs.primaryContainer, cs.primary],
              borderRadius: 100,
              borderWidth: 1,
              child: const Icon(LucideIcons.check, color: Colors.white),
            ),
            const CustomText(
              'auth.register.review_title',
              textAlign: TextAlign.center,
              type: CustomTextType.titleLarge,
              color: CustomTextColor.green,
            ),
            const CustomText(
              'auth.register.review_subtitle',
              textAlign: TextAlign.center,
              type: CustomTextType.bodyMedium,
              color: CustomTextColor.lightGreen,
            ),
            InfoDisplayTile(
              icon: LucideIcons.mail,
              labelKey: 'auth.register.review_email_label',
              value: _valueOrFallback(
                widget.email,
                'auth.register.review_placeholder_email',
              ),
            ),
            InfoDisplayTile(
              icon: LucideIcons.user,
              labelKey: 'auth.register.review_national_id_label',
              value: _valueOrFallback(
                widget.nationalId,
                'auth.register.review_placeholder_national_id',
              ),
            ),
            InfoDisplayTile(
              icon: LucideIcons.phone,
              labelKey: 'auth.register.review_phone_label',
              value: _valueOrFallback(
                widget.phone,
                'auth.register.review_placeholder_phone',
              ),
            ),
            InfoDisplayTile(
              icon: LucideIcons.barcode,
              labelKey: 'auth.register.review_barcode_label',
              value: _valueOrFallback(
                widget.barcode,
                'auth.register.review_placeholder_barcode',
              ),
            ),
            InfoDisplayTile(
              icon: LucideIcons.lock,
              labelKey: 'auth.register.review_password_label',
              value: _valueOrFallback(
                _isPasswordVisible
                    ? widget.password
                    : _maskedPassword(widget.password),
                'auth.register.review_placeholder_password',
              ),
              trailing: IconButton(
                onPressed: () =>
                    setState(() => _isPasswordVisible = !_isPasswordVisible),
                splashRadius: 20,
                icon: Icon(
                  _isPasswordVisible ? LucideIcons.eyeClosed : LucideIcons.eye,
                  color: cs.primary.withValues(alpha: 0.7),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ImportantNoteBox(
              labelKey: 'auth.register.review_warning_label',
              bodyKey: 'auth.register.review_warning_body',
              textAlign: TextAlign.start,
              backgroundColor: cs.primary.withValues(alpha: .1),
            ),
            const SizedBox(height: 18),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: GradientElevatedButton(
                    gradientColor: GradientColors.green,
                    onPressed: widget.onSend,
                    child: const CustomText(
                      'auth.register.create_account_button',
                      type: CustomTextType.titleMedium,
                      color: CustomTextColor.white,
                    ),
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: cs.primary),
                    ),
                    onPressed: widget.onBack,
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

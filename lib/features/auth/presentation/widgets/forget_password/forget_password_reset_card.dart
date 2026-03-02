import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pinput/pinput.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/core/validators/app_validators.dart';
import 'package:hajj_app/shared/widgets/app_card_container.dart';
import 'package:hajj_app/shared/widgets/circular_icon_badge.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:hajj_app/shared/widgets/gradient_elevated_button.dart';
import 'package:hajj_app/shared/widgets/required_field_label.dart';

import '../../../../../shared/widgets/important_note_box.dart';
import '../../../../../shared/widgets/numbered_steps_list.dart';

class ForgetPasswordResetCard extends StatefulWidget {
  const ForgetPasswordResetCard({
    super.key,
    required this.formKey,
    required this.email,
    required this.otpCtrl,
    required this.newPasswordCtrl,
    required this.confirmPasswordCtrl,
    required this.onSubmit,
    required this.onBack,
    required this.onResendOtp,
    this.isSubmitting = false,
    this.isResendingOtp = false,
  });

  final GlobalKey<FormState> formKey;
  final String email;
  final TextEditingController otpCtrl;
  final TextEditingController newPasswordCtrl;
  final TextEditingController confirmPasswordCtrl;
  final VoidCallback onSubmit;
  final VoidCallback onBack;
  final VoidCallback onResendOtp;
  final bool isSubmitting;
  final bool isResendingOtp;

  @override
  State<ForgetPasswordResetCard> createState() =>
      _ForgetPasswordResetCardState();
}

class _ForgetPasswordResetCardState extends State<ForgetPasswordResetCard> {
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final email = widget.email.trim().isEmpty
        ? 'auth.forget.email_hint'.tr(context)
        : widget.email.trim();

    return AppCardContainer(
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircularIconBadge(icon: LucideIcons.keyRound, iconSize: 30),
            const SizedBox(height: 12),
            const CustomText(
              'أدخل رمز التحقق',
              textAlign: TextAlign.center,
              type: CustomTextType.titleLarge,
              color: CustomTextColor.red,
            ),
            const SizedBox(height: 6),
            const CustomText(
              'تم إرسال رمز مكون من 4 أرقام إلى',
              textAlign: TextAlign.center,
              type: CustomTextType.bodyMedium,
              color: CustomTextColor.lightRed,
            ),
            const SizedBox(height: 8),
            CustomText(
              email,
              textAlign: TextAlign.center,
              type: CustomTextType.bodySmall,
              color: CustomTextColor.hint,
              translate: false,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.secondaryContainer),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomText(
                    'auth.forget.reset_next_steps',
                    type: CustomTextType.titleMedium,
                    color: CustomTextColor.red,
                  ),
                  const SizedBox(height: 10),
                  NumberedStepsList(
                    textColor: CustomTextColor.lightRed,
                    steps: [
                      'افتح بريدك الإلكتروني'.tr(context),
                      'ابحث عن رسالة من "تطبيق  بوابة الحاج"'.tr(context),
                      'انسخ رمز التحقق المكون من 4 أرقام'.tr(context),
                      'أدخل الرمز في الحقول أدناه'.tr(context),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const ImportantNoteBox(
                    labelKey: 'مهم',
                    bodyKey:
                        ' الرمز صالح لمدة 10 دقائق فقط. إذا لم تستلم الرسالة، تحقق من مجلد البريد المزعج.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Pinput(
              controller: widget.otpCtrl,
              enabled: !widget.isSubmitting,
              length: 4,
              keyboardType: TextInputType.number,
              defaultPinTheme: PinTheme(
                height: 50,
                width: 50,
                textStyle: Theme.of(context).textTheme.titleSmall,
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: cs.primary),
                  borderRadius: BorderRadius.circular(10),
                  color: cs.outline.withValues(alpha: .1),
                ),
              ),
              focusedPinTheme: PinTheme(
                height: 50,
                width: 50,
                textStyle: Theme.of(context).textTheme.titleLarge,
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: cs.brandGold),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) =>
                  AppValidators.verificationCode(value, context, length: 4),
            ),
            const SizedBox(height: 20),
            const RequiredFieldLabel('auth.forget.new_password_label'),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.newPasswordCtrl,
              obscureText: _obscureNewPassword,
              textInputAction: TextInputAction.next,
              enabled: !widget.isSubmitting,
              decoration: InputDecoration(
                hintText: 'auth.forget.new_password_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: IconButton(
                  onPressed: () => setState(
                    () => _obscureNewPassword = !_obscureNewPassword,
                  ),
                  splashRadius: 20,
                  icon: Icon(
                    _obscureNewPassword
                        ? LucideIcons.eye
                        : LucideIcons.eyeClosed,
                    color: cs.primary,
                  ),
                ),
              ),
              validator: (value) => AppValidators.password(value, context),
            ),
            const SizedBox(height: 20),
            const RequiredFieldLabel('auth.forget.confirm_password_label'),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.confirmPasswordCtrl,
              obscureText: _obscureConfirmPassword,
              textInputAction: TextInputAction.done,
              enabled: !widget.isSubmitting,
              decoration: InputDecoration(
                hintText: 'auth.forget.confirm_password_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: IconButton(
                  onPressed: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
                  splashRadius: 20,
                  icon: Icon(
                    _obscureConfirmPassword
                        ? LucideIcons.eye
                        : LucideIcons.eyeClosed,
                    color: cs.primary,
                  ),
                ),
              ),
              validator: (value) => AppValidators.confirmPassword(
                value,
                context,
                originalPassword: widget.newPasswordCtrl.text,
              ),
            ),
            const SizedBox(height: 20),
            GradientElevatedButton(
              textKey: 'auth.forget.reset_button',
              onPressed: widget.onSubmit,
              isLoading: widget.isSubmitting,
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: cs.primary),
              ),
              onPressed: widget.isSubmitting ? null : widget.onBack,
              child: const CustomText(
                'auth.forget.back_button',
                type: CustomTextType.titleMedium,
                color: CustomTextColor.green,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: (widget.isSubmitting || widget.isResendingOtp)
                  ? null
                  : widget.onResendOtp,
              child: widget.isResendingOtp
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: cs.brandGold,
                      ),
                    )
                  : const CustomText(
                      'auth.forget.resend_otp',
                      type: CustomTextType.titleSmall,
                      color: CustomTextColor.gold,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

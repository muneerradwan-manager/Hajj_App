import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pinput/pinput.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/localization/app_localizations_setup.dart';
import 'package:bawabatelhajj/core/validators/app_validators.dart';
import 'package:bawabatelhajj/shared/widgets/app_card_container.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:bawabatelhajj/shared/widgets/gradient_elevated_button.dart';

import '../../../../../shared/widgets/custom_container.dart';

class RegisterVerifyAccountCard extends StatefulWidget {
  const RegisterVerifyAccountCard({
    super.key,
    required this.formKey,
    required this.email,
    required this.onSubmit,
    required this.onResend,
    required this.pinput,
    this.resendIntervalSeconds = 113,
    this.otpLength = 4,
    this.isSubmitting = false,
    this.isResending = false,
  });

  final GlobalKey<FormState> formKey;
  final String email;
  final ValueChanged<String> onSubmit;
  final VoidCallback onResend;
  final TextEditingController pinput;
  final int resendIntervalSeconds;
  final int otpLength;
  final bool isSubmitting;
  final bool isResending;

  @override
  State<RegisterVerifyAccountCard> createState() =>
      _RegisterVerifyAccountCardState();
}

class _RegisterVerifyAccountCardState extends State<RegisterVerifyAccountCard> {
  Timer? _resendTimer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.resendIntervalSeconds;
    _startResendTimer();
  }

  void _handleSubmit() {
    if (widget.isSubmitting) return;
    if (widget.formKey.currentState?.validate() != true) return;
    widget.onSubmit(widget.pinput.text.trim());
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_remainingSeconds <= 0) {
        timer.cancel();
        return;
      }
      setState(() => _remainingSeconds -= 1);
    });
  }

  void _handleResend() {
    if (_remainingSeconds > 0 || widget.isResending) return;
    widget.onResend();
    setState(() => _remainingSeconds = widget.resendIntervalSeconds);
    _startResendTimer();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remaining = seconds % 60;
    return '$minutes:${remaining.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final email = widget.email.trim().isEmpty
        ? 'auth.register.review_placeholder_email'.tr(context)
        : widget.email.trim();

    return AppCardContainer(
      padding: const EdgeInsets.all(17),
      borderColor: cs.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomContainer(
            gradientColors: [cs.primaryContainer, cs.primary],
            borderRadius: 100,
            borderWidth: 1,
            child: const Icon(LucideIcons.shield, color: Colors.white),
          ),
          const SizedBox(height: 14),
          const CustomText(
            'auth.register.verify_title',
            textAlign: TextAlign.center,
            type: CustomTextType.headlineSmall,
            color: CustomTextColor.green,
          ),
          const SizedBox(height: 10),
          const CustomText(
            'auth.register.verify_subtitle',
            textAlign: TextAlign.center,
            type: CustomTextType.titleSmall,
            color: CustomTextColor.lightGreen,
          ),
          const SizedBox(height: 10),
          CustomText(
            email,
            textAlign: TextAlign.center,
            type: CustomTextType.titleSmall,
            color: CustomTextColor.green,
            translate: false,
          ),
          const SizedBox(height: 14),
          Form(
            key: widget.formKey,
            child: Pinput(
              controller: widget.pinput,
              enabled: !widget.isSubmitting,
              length: widget.otpLength,
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
              validator: (value) => AppValidators.verificationCode(
                value,
                context,
                length: widget.otpLength,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _remainingSeconds > 0
              ? CustomText(
                  'auth.register.verify_resend_in',
                  args: {'time': _formatTime(_remainingSeconds)},
                  textAlign: TextAlign.center,
                  type: CustomTextType.bodySmall,
                  color: CustomTextColor.lightGreen,
                )
              : TextButton(
                  onPressed: widget.isResending ? null : _handleResend,
                  child: widget.isResending
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: cs.brandGold,
                          ),
                        )
                      : const CustomText(
                          'auth.register.verify_resend_button',
                          type: CustomTextType.titleSmall,
                          color: CustomTextColor.gold,
                        ),
                ),
          const SizedBox(height: 20),
          CustomContainer(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            borderWidth: 1,
            borderColor: CustomBorderColor.hint,
            containerColor: cs.surfaceContainerHighest,
            borderRadius: 9,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText(
                  'auth.register.verify_why_title',
                  type: CustomTextType.titleSmall,
                  color: CustomTextColor.green,
                ),
                CustomText(
                  'auth.register.verify_why_body',
                  type: CustomTextType.bodySmall,
                  color: CustomTextColor.lightGreen,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GradientElevatedButton(
            textKey: 'auth.register.verify_button',
            onPressed: _handleSubmit,
            isLoading: widget.isSubmitting,
            gradientColor: GradientColors.green,
          ),
        ],
      ),
    );
  }
}

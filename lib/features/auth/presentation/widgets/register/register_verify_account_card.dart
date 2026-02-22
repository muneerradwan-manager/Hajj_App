import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/core/validators/app_validators.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:pinput/pinput.dart';

class RegisterVerifyAccountCard extends StatefulWidget {
  const RegisterVerifyAccountCard({
    super.key,
    required this.formKey,
    required this.email,
    required this.onSubmit,
    required this.onResend,
    required this.pinput,
    this.resendIntervalSeconds = 113,
  });

  final GlobalKey<FormState> formKey;
  final String email;
  final ValueChanged<String> onSubmit;
  final VoidCallback onResend;
  final TextEditingController pinput;
  final int resendIntervalSeconds;

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
      setState(() {
        _remainingSeconds -= 1;
      });
    });
  }

  void _handleResend() {
    if (_remainingSeconds > 0) return;
    widget.onResend();
    setState(() {
      _remainingSeconds = widget.resendIntervalSeconds;
    });
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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.primaryContainer),
      ),
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
                    color: cs.shadow.withValues(alpha: 0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Icon(LucideIcons.shield, color: cs.onPrimary, size: 24),
            ),
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
              length: 6,
              keyboardType: TextInputType.number,
              defaultPinTheme: PinTheme(
                height: 50,
                width: 50,
                textStyle: Theme.of(context).textTheme.titleSmall,
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: cs.primary),
                  borderRadius: BorderRadius.circular(10),
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
                  AppValidators.verificationCode(value, context),
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
                  onPressed: _handleResend,
                  child: const CustomText(
                    'auth.register.verify_resend_button',
                    type: CustomTextType.titleSmall,
                    color: CustomTextColor.gold,
                  ),
                ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: cs.outlineVariant),
            ),
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
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [cs.primaryContainer, cs.primary],
              ),
            ),
            child: ElevatedButton(
              onPressed: _handleSubmit,
              child: const CustomText(
                'auth.register.verify_button',
                type: CustomTextType.titleMedium,
                color: CustomTextColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/localization/app_localizations_setup.dart';
import '../../../../../core/validators/app_validators.dart';
import '../../../../../shared/widgets/custom_text.dart';

class RegisterSecurityCheckCard extends StatefulWidget {
  const RegisterSecurityCheckCard({
    super.key,
    required this.formKey,
    required this.passwordCtrl,
    required this.confirmCtrl,
    required this.qrcodeCtrl,
    required this.onSend,
    required this.onBack,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmCtrl;
  final TextEditingController qrcodeCtrl;
  final VoidCallback? onSend;
  final VoidCallback? onBack;

  @override
  State<RegisterSecurityCheckCard> createState() =>
      _RegisterSecurityCheckCardState();
}

class _RegisterSecurityCheckCardState extends State<RegisterSecurityCheckCard> {
  bool _obscure = true;
  bool _obscureConfirm = true;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Form(
        key: widget.formKey,
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
                child: Icon(LucideIcons.user, color: cs.onPrimary, size: 30),
              ),
            ),
            const SizedBox(height: 12),
            const CustomText(
              'auth.register.security_title',
              textAlign: TextAlign.center,
              type: CustomTextType.titleLarge,
              color: CustomTextColor.green,
            ),
            const SizedBox(height: 6),
            const CustomText(
              'auth.register.security_subtitle',
              textAlign: TextAlign.center,
              type: CustomTextType.bodyMedium,
              color: CustomTextColor.lightGreen,
            ),
            const SizedBox(height: 24),
            const CustomText(
              'auth.register.password_label',
              textAlign: TextAlign.start,
              type: CustomTextType.titleSmall,
              color: CustomTextColor.green,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.passwordCtrl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => widget.onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.password_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  splashRadius: 20,
                  icon: Icon(
                    _obscure ? LucideIcons.eye : LucideIcons.eyeClosed,
                    color: cs.primary,
                    size: 22,
                  ),
                ),
              ),
              validator: (value) => AppValidators.password(value, context),
            ),
            const SizedBox(height: 24),
            const CustomText(
              'auth.register.confirm_password_label',
              textAlign: TextAlign.start,
              type: CustomTextType.titleSmall,
              color: CustomTextColor.green,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.confirmCtrl,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => widget.onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.confirm_password_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                  splashRadius: 20,
                  icon: Icon(
                    _obscureConfirm ? LucideIcons.eye : LucideIcons.eyeClosed,
                    color: cs.primary,
                    size: 22,
                  ),
                ),
              ),
              validator: (value) => AppValidators.confirmPassword(
                value,
                context,
                originalPassword: widget.passwordCtrl.text,
              ),
            ),
            const SizedBox(height: 24),
            const CustomText(
              'auth.register.barcode_label',
              textAlign: TextAlign.start,
              type: CustomTextType.titleSmall,
              color: CustomTextColor.green,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.qrcodeCtrl,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => widget.onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.barcode_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: Icon(LucideIcons.barcode, color: cs.primary),
              ),
              validator: (value) => AppValidators.barcode(value, context),
            ),
            const SizedBox(height: 10),
            const CustomText(
              'auth.register.barcode_helper',
              textAlign: TextAlign.start,
              type: CustomTextType.bodySmall,
              color: CustomTextColor.gold,
            ),
            const SizedBox(height: 30),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onSend,
                    child: const CustomText(
                      'auth.register.next_button',
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

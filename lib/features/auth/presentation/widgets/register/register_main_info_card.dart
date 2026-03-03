import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/localization/app_localizations_setup.dart';
import 'package:bawabatelhajj/core/validators/app_validators.dart';
import 'package:bawabatelhajj/shared/widgets/app_card_container.dart';
import 'package:bawabatelhajj/shared/widgets/circular_icon_badge.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:bawabatelhajj/shared/widgets/required_field_label.dart';

class RegisterMainInfoCard extends StatelessWidget {
  const RegisterMainInfoCard({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.idCtrl,
    required this.phoneCtrl,
    required this.onSend,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final TextEditingController idCtrl;
  final TextEditingController phoneCtrl;
  final VoidCallback? onSend;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppCardContainer(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircularIconBadge(icon: LucideIcons.user),
            const SizedBox(height: 12),
            const CustomText(
              'auth.register.main_info_title',
              textAlign: TextAlign.center,
              type: CustomTextType.titleLarge,
              color: CustomTextColor.green,
            ),
            const SizedBox(height: 6),
            const CustomText(
              'auth.register.main_info_subtitle',
              textAlign: TextAlign.center,
              type: CustomTextType.bodyMedium,
              color: CustomTextColor.lightGreen,
            ),
            const SizedBox(height: 24),
            const RequiredFieldLabel('auth.register.email_label'),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.email_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: Icon(LucideIcons.mail, color: cs.primary),
              ),
              validator: (value) => AppValidators.email(value, context),
            ),
            const SizedBox(height: 24),
            const RequiredFieldLabel('auth.register.national_id_label'),
            const SizedBox(height: 10),
            TextFormField(
              controller: idCtrl,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.national_id_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: Icon(LucideIcons.user, color: cs.primary),
              ),
              validator: (value) => AppValidators.nationalId(value, context),
            ),
            const SizedBox(height: 24),
            const RequiredFieldLabel('auth.register.phone_label'),
            const SizedBox(height: 10),
            TextFormField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.phone_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: Icon(LucideIcons.phone, color: cs.primary),
              ),
              validator: (value) => AppValidators.phone(value, context),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onSend,
              child: const CustomText(
                'auth.register.next_button',
                type: CustomTextType.titleMedium,
                color: CustomTextColor.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

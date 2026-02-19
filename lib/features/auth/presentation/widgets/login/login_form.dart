import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/constants/app_routes.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/core/validators/app_validators.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';

import 'login_or_divider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: CustomText('auth.login.login_in_progress')),
      );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomText(
            'auth.login.title',
            textAlign: TextAlign.center,
            type: CustomTextType.headlineSmall,
            color: CustomTextColor.green,
          ),
          const SizedBox(height: 6),
          const CustomText(
            'auth.login.description',
            textAlign: TextAlign.center,
            type: CustomTextType.bodyMedium,
            color: CustomTextColor.lightGreen,
          ),
          const SizedBox(height: 16),
          const CustomText(
            'auth.login.phone_label',
            textAlign: TextAlign.start,
            type: CustomTextType.titleMedium,
            color: CustomTextColor.green,
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: 'auth.login.phone_hint'.tr(context),
              suffixIcon: IconButton(
                icon: const Icon(LucideIcons.user),
                color: cs.primary,
                onPressed: null,
                disabledColor: cs.primary,
              ),
            ),
            validator: (value) => AppValidators.phone(value, context),
          ),
          const SizedBox(height: 12),
          const CustomText(
            'auth.login.password_label',
            textAlign: TextAlign.start,
            type: CustomTextType.titleMedium,
            color: CustomTextColor.green,
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _passCtrl,
            textAlign: TextAlign.start,
            obscureText: _obscure,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              hintText: 'auth.login.password_hint'.tr(context),
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
          const SizedBox(height: 8),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: () => context.push(AppRoutes.forgetPasswordPath),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.keyRound, size: 17, color: cs.secondary),
                  const SizedBox(width: 4),
                  const CustomText(
                    'auth.login.forgot_password',
                    type: CustomTextType.titleSmall,
                    color: CustomTextColor.gold,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submit,
            child: const CustomText(
              'auth.login.login_button',
              type: CustomTextType.titleMedium,
              color: CustomTextColor.white,
            ),
          ),
          const SizedBox(height: 20),
          const LoginOrDivider(),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () => context.push(AppRoutes.registerPath),
            child: const CustomText(
              'auth.login.create_account',
              type: CustomTextType.titleMedium,
              color: CustomTextColor.gold,
            ),
          ),
          const SizedBox(height: 18),
          Divider(color: cs.primary, thickness: 1.1, height: 1.1),
          const SizedBox(height: 12),
          const CustomText(
            'auth.login.terms',
            textAlign: TextAlign.center,
            type: CustomTextType.bodySmall,
            color: CustomTextColor.lightGreen,
          ),
        ],
      ),
    );
  }
}

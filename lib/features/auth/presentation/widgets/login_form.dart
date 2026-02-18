import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/constants/app_routes.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';

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
        SnackBar(content: Text('auth.login.login_in_progress'.tr(context))),
      );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'auth.login.title'.tr(context),
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(color: cs.primary),
          ),
          const SizedBox(height: 6),
          Text(
            'auth.login.description'.tr(context),
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: cs.primary.withValues(alpha: 0.72),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'auth.login.phone_label'.tr(context),
            textAlign: TextAlign.start,
            style: textTheme.titleMedium?.copyWith(color: cs.primary),
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
            validator: (value) {
              final text = (value ?? '').trim();
              if (text.isEmpty) return 'auth.login.phone_required'.tr(context);
              return null;
            },
          ),
          const SizedBox(height: 12),
          Text(
            'auth.login.password_label'.tr(context),
            textAlign: TextAlign.start,
            style: textTheme.titleMedium?.copyWith(color: cs.primary),
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
            validator: (value) {
              final text = value ?? '';
              if (text.isEmpty) {
                return 'auth.login.password_required'.tr(context);
              }
              if (text.length < 6) {
                return 'auth.login.password_min_length'.tr(context);
              }
              return null;
            },
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
                  Text(
                    'auth.login.forgot_password'.tr(context),
                    style: textTheme.titleSmall?.copyWith(color: cs.secondary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: cs.shadow.withValues(alpha: 0.2),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _submit,
              child: Text(
                'auth.login.login_button'.tr(context),
                style: textTheme.titleMedium?.copyWith(color: cs.onPrimary),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const LoginOrDivider(),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {},
            child: Text(
              'auth.login.create_account'.tr(context),
              style: textTheme.titleMedium?.copyWith(color: cs.secondary),
            ),
          ),
          const SizedBox(height: 18),
          Divider(color: cs.primary, thickness: 1.1, height: 1.1),
          const SizedBox(height: 12),
          Text(
            'auth.login.terms'.tr(context),
            textAlign: TextAlign.center,
            style: textTheme.bodySmall?.copyWith(
              color: cs.primary.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }
}

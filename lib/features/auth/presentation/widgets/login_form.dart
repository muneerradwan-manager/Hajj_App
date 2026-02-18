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

  InputDecoration _inputDecoration({
    required String hint,
    required Widget trailingIcon,
  }) {
    final cs = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: cs.outline, width: 1.2),
    );

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: cs.outline, fontWeight: FontWeight.w500),
      isDense: true,
      filled: true,
      fillColor: cs.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: cs.primary, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: cs.error, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: cs.error, width: 1.4),
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: trailingIcon,
      ),
      suffixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 42),
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
            style: textTheme.headlineSmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'auth.login.description'.tr(context),
            textAlign: TextAlign.center,
            style: textTheme.titleSmall?.copyWith(
              color: cs.primary.withValues(alpha: 0.72),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'auth.login.phone_label'.tr(context),
            textAlign: TextAlign.start,
            style: textTheme.titleSmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.start,
            decoration: _inputDecoration(
              hint: 'auth.login.phone_hint'.tr(context),
              trailingIcon: IconButton(
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
            style: textTheme.titleSmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _passCtrl,
            textAlign: TextAlign.start,
            obscureText: _obscure,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            decoration: _inputDecoration(
              hint: 'auth.login.password_hint'.tr(context),
              trailingIcon: IconButton(
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
              style: TextButton.styleFrom(
                foregroundColor: cs.secondary,
                minimumSize: const Size(0, 0),
                padding: const EdgeInsets.all(5),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.keyRound, size: 17, color: cs.secondary),
                  const SizedBox(width: 4),
                  Text(
                    'auth.login.forgot_password'.tr(context),
                    style: textTheme.titleSmall?.copyWith(
                      color: cs.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5,
                    ),
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
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                elevation: 0,
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'auth.login.login_button'.tr(context),
                style: textTheme.titleMedium?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const LoginOrDivider(),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              foregroundColor: cs.secondary,
              side: BorderSide(color: cs.secondary, width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'auth.login.create_account'.tr(context),
              style: textTheme.titleMedium?.copyWith(
                color: cs.secondary,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
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
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

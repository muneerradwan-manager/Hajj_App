import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hajj_app/core/constants/app_routes.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constants/app_images.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final viewportHeight = constraints.maxHeight;
            final viewportWidth = constraints.maxWidth;
            final isTabletLayout = viewportWidth >= 700;

            final heroHeight = (viewportHeight * 0.45).clamp(320.0, 420.0);
            final overlap = (viewportHeight * 0.10).clamp(60.0, 90.0);

            final horizontalPadding = viewportWidth < 390
                ? 24.0
                : isTabletLayout
                ? 28.0
                : 18.0;
            final logoSize = (viewportWidth * 0.30).clamp(90.0, 120.0);

            return DecoratedBox(
              decoration: BoxDecoration(color: cs.surfaceDim),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.background),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: cs.primary),
                          height: heroHeight,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: _HeroSection(logoSize: logoSize),
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 1.0, end: 0.0),
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeOutQuart,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, -overlap + (value * 120)),
                              child: Opacity(
                                opacity: (1.0 - value).clamp(0.0, 1.0),
                                child: child,
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            child: const Align(
                              alignment: Alignment.topCenter,
                              child: _LoginCard(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.logoSize});

  final double logoSize;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        SizedBox(
          width: logoSize,
          height: logoSize,
          child: Hero(
            tag: 'logo',
            child: Image.asset(AppImages.logo, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'auth.login.hero_title'.tr(context),
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(
            color: cs.onPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'app.subtitle'.tr(context),
          textAlign: TextAlign.center,
          style: textTheme.titleMedium?.copyWith(
            color: cs.onPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: cs.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: const _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
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
                icon: Icon(LucideIcons.user),
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
          const _OrDivider(),
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

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(child: Divider(color: cs.primary, thickness: 1.1, height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'auth.login.or'.tr(context),
            style: textTheme.titleSmall?.copyWith(
              color: cs.primary.withValues(alpha: 0.72),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(child: Divider(color: cs.primary, thickness: 1.1, height: 1)),
      ],
    );
  }
}

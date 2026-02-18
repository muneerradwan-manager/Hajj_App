import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/constants/app_images.dart';
import 'package:hajj_app/core/constants/app_routes.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/features/auth/presentation/widgets/forget_password_sections.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  bool _isSent = false;

  @override
  void initState() {
    super.initState();
    _emailCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSent = true);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('auth.forget.snackbar_sent'.tr(context))),
      );
  }

  void _openEmailStep() {
    setState(() => _isSent = false);
  }

  void _goToLogin() {
    context.go(AppRoutes.loginPath);
  }

  void _handleBack() {
    if (_isSent) {
      setState(() => _isSent = false);
      return;
    }

    if (context.canPop()) {
      context.pop();
      return;
    }

    _goToLogin();
  }

  String? _validateEmail(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) {
      return 'auth.forget.validation_email_required'.tr(context);
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(text)) {
      return 'auth.forget.validation_email_invalid'.tr(context);
    }

    return null;
  }

  bool get _canSend => _emailCtrl.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final viewport = MediaQuery.sizeOf(context);
    final isTabletLayout = viewport.width >= 700;

    final heroHeight = (viewport.height * 0.25).clamp(220.0, 300.0);
    final overlap = (viewport.height * 0.03).clamp(16.0, 24.0);
    final horizontalPadding = viewport.width < 390
        ? 20.0
        : isTabletLayout
        ? 30.0
        : 18.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
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
                ForgetPasswordHeroHeader(
                  height: heroHeight,
                  isSent: _isSent,
                  onBack: _handleBack,
                ),
                SafeArea(
                  top: false,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.background),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      40,
                      horizontalPadding,
                      28,
                    ),
                    child: Transform.translate(
                      offset: Offset(0, -overlap),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 280),
                              switchInCurve: Curves.easeOut,
                              switchOutCurve: Curves.easeOut,
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: Tween<double>(
                                      begin: 0.98,
                                      end: 1,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                );
                              },
                              child: _isSent
                                  ? ForgetPasswordSuccessCard(
                                      key: const ValueKey('success-card'),
                                      email: _emailCtrl.text.trim(),
                                      onBackToLogin: _goToLogin,
                                      onResend: _openEmailStep,
                                    )
                                  : ForgetPasswordEmailCard(
                                      key: const ValueKey('email-card'),
                                      formKey: _formKey,
                                      emailCtrl: _emailCtrl,
                                      decoration: InputDecoration(
                                        hintText: 'auth.forget.email_hint'.tr(
                                          context,
                                        ),
                                        hintStyle: TextStyle(
                                          color: cs.outline.withValues(
                                            alpha: 0.72,
                                          ),
                                        ),
                                        suffixIcon: Icon(
                                          LucideIcons.mail,
                                          color: cs.brandGold,
                                        ),
                                      ),
                                      validateEmail: _validateEmail,
                                      onSend: _canSend ? _sendResetLink : null,
                                    ),
                            ),
                            if (!_isSent) ...[
                              const SizedBox(height: 14),
                              const ForgetPasswordSecurityNoteCard(),
                            ],
                          ],
                        ),
                      ),
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

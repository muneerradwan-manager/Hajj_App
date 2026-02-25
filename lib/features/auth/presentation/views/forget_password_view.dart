import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/constants/app_routes.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/core/validators/app_validators.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:hajj_app/shared/widgets/hero_background.dart';
import 'package:hajj_app/shared/widgets/step_animated_switcher.dart';

import '../widgets/forget_password/foregt_password_email_card.dart';
import '../widgets/forget_password/forget_password_hero_header.dart';
import '../widgets/forget_password/forget_password_security_note_card.dart';
import '../widgets/forget_password/forget_password_success_card.dart';

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
        const SnackBar(content: CustomText('auth.forget.snackbar_sent')),
      );
  }

  void _openEmailStep() => setState(() => _isSent = false);

  void _goToLogin() => context.go(AppRoutes.loginPath);

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

  String? _validateEmail(String? value) => AppValidators.email(value, context);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final viewport = MediaQuery.sizeOf(context);
    final heroHeight = (viewport.height * 0.25).clamp(220.0, 300.0);
    final overlap = (viewport.height * 0.03).clamp(16.0, 24.0);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ...HeroBackground.layers(context, heroHeight),
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Transform.translate(
                      offset: Offset(0, -overlap),
                      child: Column(
                        children: [
                          StepAnimatedSwitcher(
                            child: _isSent
                                ? ForgetPasswordSuccessCard(
                                    key: const ValueKey('success-card'),
                                    email: _emailCtrl.text.trim(),
                                    onBackToLogin: _goToLogin,
                                    onResend: _openEmailStep,
                                  )
                                : ValueListenableBuilder<TextEditingValue>(
                                    key: const ValueKey('email-card'),
                                    valueListenable: _emailCtrl,
                                    builder: (context, value, _) {
                                      final canSend = value.text
                                          .trim()
                                          .isNotEmpty;
                                      return ForgetPasswordEmailCard(
                                        formKey: _formKey,
                                        emailCtrl: _emailCtrl,
                                        decoration: InputDecoration(
                                          hintText: 'auth.forget.email_hint'.tr(
                                            context,
                                          ),
                                          hintStyle: TextStyle(
                                            color: cs.outline,
                                          ),
                                          suffixIcon: Icon(
                                            LucideIcons.mail,
                                            color: cs.brandGold,
                                          ),
                                        ),
                                        validateEmail: _validateEmail,
                                        onSend: canSend ? _sendResetLink : null,
                                      );
                                    },
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/constants/app_routes.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/core/validators/app_validators.dart';
import 'package:hajj_app/features/auth/presentation/cubits/forget_password/forget_password_cubit.dart';
import 'package:hajj_app/features/auth/presentation/cubits/forget_password/forget_password_state.dart';
import 'package:hajj_app/shared/widgets/hero_background.dart';
import 'package:hajj_app/shared/widgets/step_animated_switcher.dart';

import '../../../../shared/widgets/custom_snackbar.dart';
import '../widgets/forget_password/foregt_password_email_card.dart';
import '../widgets/forget_password/forget_password_hero_header.dart';
import '../widgets/forget_password/forget_password_reset_card.dart';
import '../widgets/forget_password/forget_password_security_note_card.dart';
import '../widgets/forget_password/forget_password_success_card.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _emailFormKey = GlobalKey<FormState>();
  final _resetFormKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _otpCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _sendResetOtp() {
    if (_emailFormKey.currentState?.validate() != true) return;
    context.read<ForgetPasswordCubit>().sendResetOtp(_emailCtrl.text);
  }

  void _submitResetPassword() {
    if (_resetFormKey.currentState?.validate() != true) return;
    context.read<ForgetPasswordCubit>().submitResetPassword(
      otp: _otpCtrl.text,
      newPassword: _newPasswordCtrl.text,
      confirmPassword: _confirmPasswordCtrl.text,
    );
  }

  void _resendOtp() {
    context.read<ForgetPasswordCubit>().sendResetOtp(
      _emailCtrl.text,
      isResend: true,
    );
  }

  void _goToLogin() => context.go(AppRoutes.loginPath);

  void _handleBack(ForgetPasswordState state) {
    if (state.stepNumber >= 3) {
      _goToLogin();
      return;
    }

    if (state.stepNumber > 1) {
      context.read<ForgetPasswordCubit>().backStep();
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
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.infoMessage != current.infoMessage,
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          showMessage(context, state.errorMessage, SnackBarType.failuer);
          context.read<ForgetPasswordCubit>().clearMessages();
          return;
        }

        if (state.infoMessage.isNotEmpty) {
          showMessage(context, state.infoMessage, SnackBarType.info);
          context.read<ForgetPasswordCubit>().clearMessages();
        }
      },
      builder: (context, state) {
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
                      stepNumber: state.stepNumber,
                      onBack: () => _handleBack(state),
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
                                child: _buildStep(state, cs),
                              ),
                              if (state.stepNumber == 1) ...[
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
      },
    );
  }

  Widget _buildStep(ForgetPasswordState state, ColorScheme cs) {
    return switch (state.stepNumber) {
      1 => ValueListenableBuilder<TextEditingValue>(
        key: const ValueKey('email-card'),
        valueListenable: _emailCtrl,
        builder: (context, value, _) {
          final canSend = value.text.trim().isNotEmpty;
          return ForgetPasswordEmailCard(
            formKey: _emailFormKey,
            emailCtrl: _emailCtrl,
            decoration: InputDecoration(
              hintText: 'auth.forget.email_hint'.tr(context),
              hintStyle: TextStyle(color: cs.outline),
              suffixIcon: Icon(LucideIcons.mail, color: cs.brandGold),
            ),
            validateEmail: _validateEmail,
            onSend: canSend ? _sendResetOtp : null,
            isLoading: state.isSendingOtp,
          );
        },
      ),
      2 => ForgetPasswordResetCard(
        key: const ValueKey('reset-card'),
        formKey: _resetFormKey,
        email: state.email,
        otpCtrl: _otpCtrl,
        newPasswordCtrl: _newPasswordCtrl,
        confirmPasswordCtrl: _confirmPasswordCtrl,
        onSubmit: _submitResetPassword,
        onBack: () => _handleBack(state),
        onResendOtp: _resendOtp,
        isSubmitting: state.isResettingPassword,
        isResendingOtp: state.isResendingOtp,
      ),
      _ => ForgetPasswordSuccessCard(
        key: const ValueKey('success-card'),
        email: state.email.trim().isEmpty
            ? _emailCtrl.text.trim()
            : state.email,
        onBackToLogin: _goToLogin,
      ),
    };
  }
}

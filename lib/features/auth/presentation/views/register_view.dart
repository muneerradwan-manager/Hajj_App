import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:bawabatelhajj/core/constants/app_routes.dart';
import 'package:bawabatelhajj/features/auth/domain/entities/register_draft.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/register/register_state.dart';
import 'package:bawabatelhajj/shared/widgets/hero_background.dart';
import 'package:bawabatelhajj/shared/widgets/step_animated_switcher.dart';

import '../../../../shared/widgets/custom_snackbar.dart';
import '../widgets/register/register_hero_header.dart';
import '../widgets/register/register_main_info_card.dart';
import '../widgets/register/register_review_data_card.dart';
import '../widgets/register/register_security_check_card.dart';
import '../widgets/register/register_success_card.dart';
import '../widgets/register/register_verify_account_card.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _isDraftHydrated = false;

  // step one
  final _formMainInfoKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _idCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  // step two
  final _formSecurityCheckKey = GlobalKey<FormState>();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _qrCodeCtrl = TextEditingController();
  // step three
  final _formSubmitKey = GlobalKey<FormState>();
  // step four
  final _formVerifyAccountKey = GlobalKey<FormState>();
  final _pinput = TextEditingController();

  void _handleBack() {
    final stepNumber = context.read<RegisterCubit>().state.stepNumber;
    if (stepNumber <= 1) {
      _goToLogin();
      return;
    }
    context.read<RegisterCubit>().goBackStep();
  }

  void _goToLogin() => context.go(AppRoutes.loginPath);

  bool _isFormValid(GlobalKey<FormState> formKey) {
    final state = formKey.currentState;
    if (state == null) return false;
    return state.validate();
  }

  void _submitMainInfo() {
    if (!_isFormValid(_formMainInfoKey)) return;
    context.read<RegisterCubit>().saveMainInfo(
      email: _emailCtrl.text,
      phone: _phoneCtrl.text,
      nationalityNumber: _idCtrl.text,
    );
  }

  void _submitSecurityCheck() {
    if (!_isFormValid(_formSecurityCheckKey)) return;
    context.read<RegisterCubit>().saveSecurityInfo(
      password: _passwordCtrl.text,
      confirmPassword: _confirmCtrl.text,
      barcode: _qrCodeCtrl.text,
    );
  }

  void _submitReviewData() {
    if (!_isFormValid(_formSubmitKey)) return;
    context.read<RegisterCubit>().submitRegister();
  }

  void _submitVerificationCode(String otp) {
    context.read<RegisterCubit>().confirmEmail(otp);
  }

  void _hydrateControllers(RegisterDraft draft) {
    if (_isDraftHydrated) return;

    _emailCtrl.text = draft.email;
    _idCtrl.text = draft.nationalityNumber;
    _phoneCtrl.text = draft.phone;
    _passwordCtrl.text = draft.password;
    _confirmCtrl.text = draft.confirmPassword;
    _qrCodeCtrl.text = draft.barcode;
    _pinput.clear();

    _isDraftHydrated = true;
  }

  void _resendVerificationCode() {
    context.read<RegisterCubit>().resendConfirmEmail();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _idCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _qrCodeCtrl.dispose();
    _pinput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          previous.isHydrated != current.isHydrated ||
          previous.errorMessage != current.errorMessage ||
          previous.infoMessage != current.infoMessage,
      listener: (context, state) {
        if (state.isHydrated) {
          _hydrateControllers(state.draft);
        }

        if (state.errorMessage.isNotEmpty) {
          showMessage(context, state.errorMessage, SnackBarType.failuer);
          context.read<RegisterCubit>().clearMessages();
          return;
        }

        if (state.infoMessage.isNotEmpty) {
          showMessage(context, state.infoMessage, SnackBarType.info);
          context.read<RegisterCubit>().clearMessages();
        }
      },
      builder: (context, state) {
        final viewport = MediaQuery.sizeOf(context);
        final heroHeight = (viewport.height * 0.25).clamp(220.0, 300.0);
        final overlap = (viewport.height * 0.03).clamp(16.0, 24.0);
        final statusBarInset = MediaQuery.paddingOf(context).top;
        final totalHeroHeight = heroHeight + statusBarInset;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                ...HeroBackground.layers(context, totalHeroHeight),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RegisterHeroHeader(
                      height: heroHeight,
                      stepNumber: state.stepNumber,
                      onBack: _handleBack,
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Transform.translate(
                          offset: Offset(0, -overlap),
                          child: StepAnimatedSwitcher(
                            child: state.isHydrated
                                ? _buildStep(state)
                                : const SizedBox(
                                    key: ValueKey('register-loading'),
                                    height: 260,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
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
      },
    );
  }

  Widget _buildStep(RegisterState state) {
    return switch (state.stepNumber) {
      1 => RegisterMainInfoCard(
        key: const ValueKey('main-info-card'),
        formKey: _formMainInfoKey,
        emailCtrl: _emailCtrl,
        idCtrl: _idCtrl,
        phoneCtrl: _phoneCtrl,
        onSend: _submitMainInfo,
      ),
      2 => RegisterSecurityCheckCard(
        key: const ValueKey('security-check-card'),
        formKey: _formSecurityCheckKey,
        passwordCtrl: _passwordCtrl,
        confirmCtrl: _confirmCtrl,
        qrcodeCtrl: _qrCodeCtrl,
        onSend: _submitSecurityCheck,
        onBack: _handleBack,
      ),
      3 => RegisterReviewDataCard(
        key: const ValueKey('review-data-card'),
        formKey: _formSubmitKey,
        email: state.draft.email,
        nationalId: state.draft.nationalityNumber,
        phone: state.draft.phone,
        barcode: state.draft.barcode,
        password: state.draft.password,
        onSend: state.isSubmitting ? null : _submitReviewData,
        onBack: state.isSubmitting ? null : _handleBack,
      ),
      4 => RegisterVerifyAccountCard(
        key: const ValueKey('verify-account-card'),
        formKey: _formVerifyAccountKey,
        pinput: _pinput,
        onSubmit: _submitVerificationCode,
        email: state.draft.email,
        onResend: _resendVerificationCode,
        isSubmitting: state.isConfirmingEmail,
        isResending: state.isResendingCode,
      ),
      _ => RegisterSuccessCard(
        key: const ValueKey('success-card'),
        onContinueToLogin: _goToLogin,
      ),
    };
  }
}

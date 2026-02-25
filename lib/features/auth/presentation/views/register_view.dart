import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hajj_app/core/constants/app_routes.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:hajj_app/shared/widgets/hero_background.dart';
import 'package:hajj_app/shared/widgets/step_animated_switcher.dart';

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

  int _stepNumber = 1;

  void _handleBack() {
    if (_stepNumber <= 1) {
      _goToLogin();
      return;
    }
    setState(() => _stepNumber -= 1);
  }

  void _goToLogin() => context.go(AppRoutes.loginPath);

  void _goNext() {
    if (_stepNumber >= 5) return;
    setState(() => _stepNumber += 1);
  }

  bool _isFormValid(GlobalKey<FormState> formKey) {
    final state = formKey.currentState;
    if (state == null) return false;
    return state.validate();
  }

  void _submitMainInfo() {
    if (!_isFormValid(_formMainInfoKey)) return;
    _goNext();
  }

  void _submitSecurityCheck() {
    if (!_isFormValid(_formSecurityCheckKey)) return;
    _goNext();
  }

  void _submitReviewData() {
    if (!_isFormValid(_formSubmitKey)) return;
    _goNext();
  }

  void _submitVerificationCode(String _) => _goNext();

  void _resendVerificationCode() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: CustomText(
            'auth.register.verify_resend_sent'.tr(context),
            translate: false,
          ),
        ),
      );
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
                  stepNumber: _stepNumber,
                  onBack: _handleBack,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Transform.translate(
                      offset: Offset(0, -overlap),
                      child: StepAnimatedSwitcher(child: _buildStep()),
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

  Widget _buildStep() {
    return switch (_stepNumber) {
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
          email: _emailCtrl.text.trim(),
          nationalId: _idCtrl.text.trim(),
          phone: _phoneCtrl.text.trim(),
          barcode: _qrCodeCtrl.text.trim(),
          password: _passwordCtrl.text.trim(),
          onSend: _submitReviewData,
          onBack: _handleBack,
        ),
      4 => RegisterVerifyAccountCard(
          key: const ValueKey('verify-account-card'),
          formKey: _formVerifyAccountKey,
          pinput: _pinput,
          onSubmit: _submitVerificationCode,
          email: _emailCtrl.text.trim(),
          onResend: _resendVerificationCode,
        ),
      _ => RegisterSuccessCard(
          key: const ValueKey('success-card'),
          onContinueToLogin: _goToLogin,
        ),
    };
  }
}

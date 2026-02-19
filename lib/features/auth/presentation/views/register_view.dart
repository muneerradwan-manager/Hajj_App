import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hajj_app/features/auth/presentation/widgets/register/register_hero_header.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_routes.dart';
import '../widgets/register/register_main_info_card.dart';
import '../widgets/register/register_password_success_card.dart';
import '../widgets/register/register_review_data_card.dart';
import '../widgets/register/register_security_check_card.dart';

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
  // step three (final)
  final _formSubmitKey = GlobalKey<FormState>();
  final data = <String, dynamic>{};

  int _stepNumber = 1;

  void _handleBack() {
    if (_stepNumber <= 1) {
      _goToLogin();
      return;
    }

    setState(() {
      _stepNumber -= 1; // <-- رجوع خطوة للخلف
    });
  }

  void _goToLogin() {
    context.go(AppRoutes.loginPath);
  }

  void _goNext() {
    if (_stepNumber >= 4) return;
    setState(() => _stepNumber += 1);
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RegisterHeroHeader(
              height: heroHeight,
              stepNumber: _stepNumber,
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
                          child: _stepNumber == 1
                              ? RegisterMainInfoCard(
                                  key: const ValueKey('main-info-card'),
                                  formKey: _formMainInfoKey,
                                  emailCtrl: _emailCtrl,
                                  idCtrl: _idCtrl,
                                  phoneCtrl: _phoneCtrl,
                                  onSend: _goNext,
                                )
                              : _stepNumber == 2
                              ? RegisterSecurityCheckCard(
                                  formKey: _formSecurityCheckKey,
                                  passwordCtrl: _passwordCtrl,
                                  confirmCtrl: _confirmCtrl,
                                  qrcodeCtrl: _qrCodeCtrl,
                                  onSend: _goNext,
                                  onBack: _handleBack,
                                )
                              : _stepNumber == 3
                              ? RegisterReviewDataCard(
                                  formKey: _formSubmitKey,
                                  data: data,
                                  onSend: _goNext,
                                  onBack: _handleBack,
                                )
                              : RegisterPasswordSuccessCard(
                                  onContinueToLogin: _goToLogin,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

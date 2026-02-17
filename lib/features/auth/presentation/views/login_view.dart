import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import 'package:hajj_app/core/constants/app_routes.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              decoration: const BoxDecoration(
                color: _LoginPalette.pageBackground,
              ),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: IgnorePointer(
                        child: Opacity(
                          opacity: 0.18,
                          child: CustomPaint(painter: _PatternPainter()),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: _LoginPalette.heroBackground,
                            image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
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
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: const _LoginCard(),
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
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        SizedBox(
          width: logoSize,
          height: logoSize,
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 12),
        Text(
          'auth.login.hero_title'.tr(context),
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(
            color: _LoginPalette.heroTitle,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'app.subtitle'.tr(context),
          textAlign: TextAlign.center,
          style: textTheme.titleMedium?.copyWith(
            color: _LoginPalette.heroSubtitle,
            fontWeight: FontWeight.w400,
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
      decoration: BoxDecoration(
        color: _LoginPalette.cardBackground,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: _LoginPalette.cardShadow,
            blurRadius: 28,
            offset: Offset(0, 14),
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
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: _LoginPalette.inputBorder, width: 1.2),
    );

    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: _LoginPalette.inputHint,
        fontWeight: FontWeight.w500,
      ),
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      border: border,
      enabledBorder: border,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: _LoginPalette.inputFocusedBorder,
          width: 1.4,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: _LoginPalette.errorBorder, width: 1.2),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: _LoginPalette.errorBorder, width: 1.4),
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
              color: _LoginPalette.primaryText,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'auth.login.description'.tr(context),
            textAlign: TextAlign.center,
            style: textTheme.titleSmall?.copyWith(
              color: _LoginPalette.secondaryText,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'auth.login.phone_label'.tr(context),
            textAlign: TextAlign.start,
            style: textTheme.titleSmall?.copyWith(
              color: _LoginPalette.primaryText,
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
              trailingIcon: const Icon(
                Iconsax.user,
                color: _LoginPalette.inputIcon,
                size: 22,
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
              color: _LoginPalette.primaryText,
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
                  _obscure ? Iconsax.eye : Iconsax.eye_slash,
                  color: _LoginPalette.inputIcon,
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
                foregroundColor: _LoginPalette.goldAction,
                minimumSize: const Size(0, 0),
                padding: EdgeInsets.all(5),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Iconsax.key,
                    size: 17,
                    color: _LoginPalette.goldAction,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'auth.login.forgot_password'.tr(context),
                    style: textTheme.titleSmall?.copyWith(
                      color: _LoginPalette.goldAction,
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
              boxShadow: const [
                BoxShadow(
                  color: _LoginPalette.primaryButtonShadow,
                  blurRadius: 14,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                elevation: 0,
                backgroundColor: _LoginPalette.primaryButton,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'auth.login.login_button'.tr(context),
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
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
              foregroundColor: _LoginPalette.goldAction,
              side: const BorderSide(
                color: _LoginPalette.goldAction,
                width: 1.2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'auth.login.create_account'.tr(context),
              style: textTheme.titleMedium?.copyWith(
                color: _LoginPalette.goldAction,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Divider(
            color: _LoginPalette.divider,
            thickness: 1.1,
            height: 1.1,
          ),
          const SizedBox(height: 12),
          Text(
            'auth.login.terms'.tr(context),
            textAlign: TextAlign.center,
            style: textTheme.bodySmall?.copyWith(
              color: _LoginPalette.termsText,
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
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: _LoginPalette.divider,
            thickness: 1.1,
            height: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'auth.login.or'.tr(context),
            style: textTheme.titleSmall?.copyWith(
              color: _LoginPalette.secondaryText,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: _LoginPalette.divider,
            thickness: 1.1,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _PatternPainter extends CustomPainter {
  const _PatternPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const double tile = 82;
    final stroke = Paint()
      ..color = _LoginPalette.patternStroke
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final dot = Paint()
      ..color = _LoginPalette.patternDot
      ..style = PaintingStyle.fill;

    for (double y = -tile; y <= size.height + tile; y += tile) {
      for (double x = -tile; x <= size.width + tile; x += tile) {
        final center = Offset(x + (tile / 2), y + (tile / 2));
        final half = tile * 0.32;

        final diamond = Path()
          ..moveTo(center.dx, center.dy - half)
          ..lineTo(center.dx + half, center.dy)
          ..lineTo(center.dx, center.dy + half)
          ..lineTo(center.dx - half, center.dy)
          ..close();

        canvas.drawPath(diamond, stroke);
        canvas.drawCircle(center, tile * 0.08, dot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LoginPalette {
  const _LoginPalette._();

  static const Color heroBackground = Color(0xFF00594F);
  static const Color pageBackground = Color(0xFFF6F6F4);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1F052E2A);
  static const Color heroTitle = Color(0xFFF7FFFC);
  static const Color heroSubtitle = Color(0xFFE3DDD2);
  static const Color primaryText = Color(0xFF016258);
  static const Color secondaryText = Color(0xFF409E95);
  static const Color termsText = Color(0xFF1F8F85);
  static const Color inputBorder = Color(0xFF7BC8C1);
  static const Color inputFocusedBorder = Color(0xFF2BAA9E);
  static const Color inputHint = Color(0xFFC5CBC8);
  static const Color inputIcon = Color(0xFF22ACA0);
  static const Color errorBorder = Color(0xFFBA1A1A);
  static const Color primaryButton = Color(0xFF0B9D8D);
  static const Color primaryButtonShadow = Color(0x33206B63);
  static const Color divider = Color(0xFF8CCFC7);
  static const Color goldAction = Color(0xFFC8B27F);
  static const Color patternStroke = Color(0x408BAEAA);
  static const Color patternDot = Color(0x208BAEAA);
}

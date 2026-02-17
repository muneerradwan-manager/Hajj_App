import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hajj_app/core/constants/app_routes.dart';

import '../../../../shared/widgets/directional_back_arrow.dart';

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
        const SnackBar(
          content: Text('تم إرسال رابط الاستعادة إلى بريدك الإلكتروني'),
        ),
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
    if (text.isEmpty) return 'البريد الإلكتروني مطلوب';

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(text)) return 'صيغة البريد الإلكتروني غير صحيحة';

    return null;
  }

  InputDecoration _emailDecoration() {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(11)),
      borderSide: BorderSide(
        color: _ForgetPasswordPalette.inputBorder,
        width: 1.15,
      ),
    );

    return InputDecoration(
      hintText: 'example@hajj.sa',
      hintStyle: TextStyle(color: Color(0xff672146).withValues(alpha: .52)),
      hintTextDirection: TextDirection.ltr,
      isDense: true,
      filled: true,
      fillColor: Color(0xFFFBFBFA),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(11)),
        borderSide: BorderSide(
          color: _ForgetPasswordPalette.inputFocusedBorder,
          width: 1.35,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(11)),
        borderSide: BorderSide(
          color: _ForgetPasswordPalette.errorBorder,
          width: 1.2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(11)),
        borderSide: BorderSide(
          color: _ForgetPasswordPalette.errorBorder,
          width: 1.35,
        ),
      ),
      suffixIcon: Padding(
        padding: EdgeInsets.only(left: 8, right: 6),
        child: Icon(
          Icons.mail_outline_rounded,
          color: _ForgetPasswordPalette.inputIcon,
          size: 20,
        ),
      ),
      suffixIconConstraints: BoxConstraints(minWidth: 42, minHeight: 40),
    );
  }

  @override
  void initState() {
    super.initState();
    _emailCtrl.addListener(() => setState(() {}));
  }

  bool get _canSend => _emailCtrl.text.trim().isNotEmpty;

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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: _ForgetPasswordPalette.pageBackground,
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Stack(
              children: [
                const Positioned.fill(
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: 0.2,
                      child: CustomPaint(painter: _PatternPainter()),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeroHeader(
                      height: heroHeight,
                      isSent: _isSent,
                      onBack: _handleBack,
                    ),
                    Padding(
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
                                    ? _SuccessCard(
                                        key: const ValueKey('success-card'),
                                        email: _emailCtrl.text.trim(),
                                        onBackToLogin: _goToLogin,
                                        onResend: _openEmailStep,
                                      )
                                    : _EmailCard(
                                        key: const ValueKey('email-card'),
                                        formKey: _formKey,
                                        emailCtrl: _emailCtrl,
                                        decoration: _emailDecoration(),
                                        validateEmail: _validateEmail,
                                        onSend: _canSend
                                            ? _sendResetLink
                                            : null, // <-- هنا
                                      ),
                              ),
                              if (!_isSent) ...[
                                const SizedBox(height: 14),
                                const _SecurityNoteCard(),
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
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({
    required this.height,
    required this.isSent,
    required this.onBack,
  });

  final double height;
  final bool isSent;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final statusBarInset = MediaQuery.paddingOf(context).top;

    return Container(
      height: height + statusBarInset,
      padding: EdgeInsets.fromLTRB(20, statusBarInset + 10, 20, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _ForgetPasswordPalette.heroTop,
            _ForgetPasswordPalette.heroBottom,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DirectionalBackArrow(
                onPressed: onBack,
                color: _ForgetPasswordPalette.heroTitle,
              ),

              Expanded(
                child: Text(
                  'استعادة كلمة المرور',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall?.copyWith(
                    color: _ForgetPasswordPalette.heroTitle,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(width: 42),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            isSent ? 'تم الإرسال بنجاح' : 'أدخل بريدك الإلكتروني',
            textAlign: TextAlign.center,
            style: textTheme.titleSmall?.copyWith(
              color: _ForgetPasswordPalette.heroSubtitle,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 14),
          _StepProgress(isSent: isSent),
        ],
      ),
    );
  }
}

class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.isSent});

  final bool isSent;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: _ForgetPasswordPalette.progressBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 240),
              tween: Tween<double>(begin: 0, end: isSent ? 1 : 0.5),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 4,
                  backgroundColor: _ForgetPasswordPalette.progressTrack,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    _ForgetPasswordPalette.progressValue,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'الخطوة ${isSent ? 2 : 1} من 2',
            style: textTheme.bodySmall?.copyWith(
              color: _ForgetPasswordPalette.progressLabel,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailCard extends StatelessWidget {
  const _EmailCard({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.decoration,
    required this.validateEmail,
    required this.onSend,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final InputDecoration decoration;
  final String? Function(String?) validateEmail;
  final VoidCallback? onSend;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _ForgetPasswordPalette.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _ForgetPasswordPalette.cardBorder),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: _ForgetPasswordPalette.iconCircle,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _ForgetPasswordPalette.iconShadow,
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mail_outline_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'أدخل بريدك الإلكتروني',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                color: _ForgetPasswordPalette.primaryText,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'سنرسل لك رابط استعادة كلمة المرور',
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(
                color: _ForgetPasswordPalette.secondaryText,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'البريد الإلكتروني *',
              textAlign: TextAlign.right,
              style: textTheme.titleSmall?.copyWith(
                color: Color(0xff420023),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              textDirection: TextDirection.ltr,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: decoration,
              validator: validateEmail,
            ),
            const SizedBox(height: 20),
            Opacity(
              opacity: onSend == null ? 0.5 : 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _ForgetPasswordPalette.primaryButtonTop,
                      _ForgetPasswordPalette.primaryButtonBottom,
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: _ForgetPasswordPalette.primaryButtonShadow,
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: onSend, // null => disabled automatically
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'إرسال رابط الاستعادة',
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.send_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'سيتم إرسال رابط آمن لتغيير كلمة المرور إلى بريدك الإلكتروني',
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: _ForgetPasswordPalette.helperText,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityNoteCard extends StatelessWidget {
  const _SecurityNoteCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffE3DDD2), Color(0xffD9C89E)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 17,
                color: _ForgetPasswordPalette.noteTitle,
              ),
              const SizedBox(width: 4),
              Text(
                'نصيحة أمنية',
                style: textTheme.titleSmall?.copyWith(
                  color: _ForgetPasswordPalette.noteTitle,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'تأكد من إدخال بريدك الصحيح. في حال النسيان أو طلبات متعددة خلال وقت قصير، راجع البريد الإلكتروني (بما فيها البريد غير المرغوب) قبل طلب إعادة الإرسال.',
            style: textTheme.bodySmall?.copyWith(
              color: _ForgetPasswordPalette.noteBody,
              height: 1.45,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessCard extends StatelessWidget {
  const _SuccessCard({
    super.key,
    required this.email,
    required this.onBackToLogin,
    required this.onResend,
  });

  final String email;
  final VoidCallback onBackToLogin;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: _ForgetPasswordPalette.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _ForgetPasswordPalette.successBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            child: Container(
              width: 92,
              height: 92,
              decoration: const BoxDecoration(
                color: _ForgetPasswordPalette.successCircle,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _ForgetPasswordPalette.iconShadow,
                    blurRadius: 16,
                    offset: Offset(0, 7),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 56,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'تم الإرسال بنجاح!',
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
              color: _ForgetPasswordPalette.successTitle,
              fontWeight: FontWeight.w500,
              fontSize: 24,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'تم إرسال رابط استعادة كلمة المرور',
            textAlign: TextAlign.center,
            style: textTheme.titleSmall?.copyWith(
              color: Color(0xff672146),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            email,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: textTheme.titleSmall?.copyWith(
              color: _ForgetPasswordPalette.helperText,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF9F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _ForgetPasswordPalette.noteBackground),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الخطوات التالية:',
                      style: textTheme.titleSmall?.copyWith(
                        color: Color(0xff420023),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const _StepLine(number: 1, text: 'افتح بريدك الإلكتروني'),
                const SizedBox(height: 7),
                const _StepLine(
                  number: 2,
                  text: 'اضغط على الرابط المرفق في الرسالة',
                ),
                const SizedBox(height: 7),
                const _StepLine(number: 3, text: 'قم بتعيين كلمة مرور جديدة'),
                const SizedBox(height: 7),
                const _StepLine(
                  number: 4,
                  text: 'سجّل الدخول باستخدام كلمة المرور الجديدة',
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6F6),
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: const Color(0xFFD1E6E3)),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'مهم: ',
                          style: textTheme.bodySmall?.copyWith(
                            color: _ForgetPasswordPalette
                                .heroBottom, // <-- لون "مهم"
                            fontWeight: FontWeight.w800,
                            fontSize: 13, // <-- حجم "مهم"
                            height: 1.4,
                          ),
                        ),
                        TextSpan(
                          text:
                              'الرابط صالح لمدة 24 ساعة فقط. إذا لم تصلك الرسالة تحقق من مجلد البريد المزعج.',
                          style: textTheme.bodySmall?.copyWith(
                            color: _ForgetPasswordPalette
                                .heroBottom, // لون باقي النص
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _ForgetPasswordPalette.primaryButtonTop,
                  _ForgetPasswordPalette.primaryButtonBottom,
                ],
              ),
            ),
            child: ElevatedButton(
              onPressed: onBackToLogin,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                elevation: 0,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'العودة لتسجيل الدخول',
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: onResend,
            style: TextButton.styleFrom(
              foregroundColor: _ForgetPasswordPalette.successLink,
              minimumSize: const Size(0, 0),
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'لم تستلم الرسالة؟ إعادة الإرسال',
              style: textTheme.titleSmall?.copyWith(
                color: _ForgetPasswordPalette.successLink,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: _ForgetPasswordPalette.successCircle,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: textTheme.bodySmall?.copyWith(
              color: Color(0xff672146),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
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
    const tile = 78.0;
    final stroke = Paint()
      ..color = _ForgetPasswordPalette.patternStroke
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (double y = -tile; y <= size.height + tile; y += tile) {
      for (double x = -tile; x <= size.width + tile; x += tile) {
        final center = Offset(x + (tile / 2), y + (tile / 2));
        final half = tile * 0.34;

        final archPath = Path()
          ..moveTo(center.dx - half, center.dy + half * 0.1)
          ..lineTo(center.dx - half, center.dy + half)
          ..lineTo(center.dx + half, center.dy + half)
          ..lineTo(center.dx + half, center.dy + half * 0.1)
          ..quadraticBezierTo(
            center.dx,
            center.dy - half * 0.9,
            center.dx - half,
            center.dy + half * 0.1,
          );

        canvas.drawPath(archPath, stroke);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ForgetPasswordPalette {
  const _ForgetPasswordPalette._();

  static const Color heroTop = Color(0xFF2AA59A);
  static const Color heroBottom = Color(0xFF00594F);

  static const Color pageBackground = Color(0xFFF6F7F6);
  static const Color patternStroke = Color(0x3388A7A3);

  static const Color heroTitle = Color(0xFFE9FFFA);
  static const Color heroSubtitle = Color(0xFFCDE8DF);

  static const Color progressBackground = Color(0x1FFFFFFF);
  static const Color progressTrack = Color(0x40D6F2EB);
  static const Color progressValue = Color(0xFFE6D598);
  static const Color progressLabel = Color(0xFFD3F0EA);

  static const Color cardBackground = Color(0xFFFDFDFD);
  static const Color cardBorder = Color(0xFFD6D9D8);

  static const Color primaryText = Color(0xFF4E1E3C);
  static const Color secondaryText = Color(0xFFA68C8B);
  static const Color helperText = Color(0xFFB5A688);

  static const Color inputBorder = Color(0xFFE3D9C3);
  static const Color inputFocusedBorder = Color(0xFF4EB8AB);
  static const Color inputIcon = Color(0xFFB9A574);
  static const Color errorBorder = Color(0xFFBA1A1A);

  static const Color iconCircle = Color(0xFF219A8E);
  static const Color iconShadow = Color(0x33205650);

  static const Color primaryButtonTop = Color(0xFF2FAEA0);
  static const Color primaryButtonBottom = Color(0xFF007E71);
  static const Color primaryButtonShadow = Color(0x3322746C);

  static const Color noteBackground = Color(0xFFF0E8D2);
  static const Color noteTitle = Color(0xFF6C1D35);
  static const Color noteBody = Color(0xFF7D3E4D);

  static const Color successBorder = Color(0xFF7ECABD);
  static const Color successCircle = Color(0xFF1E9B8D);
  static const Color successTitle = Color(0xFF7A2345);
  static const Color successLink = Color(0xFF2A9F91);
}

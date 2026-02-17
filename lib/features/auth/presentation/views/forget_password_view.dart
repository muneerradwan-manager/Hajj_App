import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hajj_app/core/constants/app_routes.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constants/app_images.dart';
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

  InputDecoration _emailDecoration() {
    final cs = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(11)),
      borderSide: BorderSide(color: cs.outline, width: 1.15),
    );

    return InputDecoration(
      hintText: 'auth.forget.email_hint'.tr(context),
      hintStyle: TextStyle(color: cs.outline.withValues(alpha: 0.72)),
      hintTextDirection: TextDirection.ltr,
      isDense: true,
      filled: true,
      fillColor: cs.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(11)),
        borderSide: BorderSide(color: cs.primary, width: 1.35),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(11)),
        borderSide: BorderSide(color: cs.error, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(11)),
        borderSide: BorderSide(color: cs.error, width: 1.35),
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.only(left: 8, right: 6),
        child: Icon(LucideIcons.mail, color: cs.secondary, size: 20),
      ),
      suffixIconConstraints: const BoxConstraints(minWidth: 42, minHeight: 40),
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
      body: DecoratedBox(
        decoration: BoxDecoration(color: cs.surfaceDim),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  _HeroHeader(
                    height: heroHeight,
                    isSent: _isSent,
                    onBack: _handleBack,
                  ),
                  Container(
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
                                      onSend: _canSend ? _sendResetLink : null,
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
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final statusBarInset = MediaQuery.paddingOf(context).top;

    return Container(
      height: height + statusBarInset,
      padding: EdgeInsets.fromLTRB(20, statusBarInset + 10, 20, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [cs.primaryContainer, cs.primary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DirectionalBackArrow(onPressed: onBack, color: cs.onPrimary),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'auth.forget.title'.tr(context),
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    isSent
                        ? 'auth.forget.header_sent'.tr(context)
                        : 'auth.forget.header_enter_email'.tr(context),
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall?.copyWith(
                      color: cs.secondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),
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
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: cs.onPrimary.withValues(alpha: 0.12),
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
                  backgroundColor: cs.onPrimary.withValues(alpha: 0.28),
                  valueColor: AlwaysStoppedAnimation<Color>(cs.secondary),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'auth.forget.step_indicator'.tr(
              context,
              args: {'current': isSent ? 2 : 1, 'total': 2},
            ),
            style: textTheme.bodySmall?.copyWith(
              color: cs.onPrimary.withValues(alpha: 0.88),
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
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
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
                decoration: BoxDecoration(
                  color: cs.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: cs.shadow.withValues(alpha: 0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(LucideIcons.mail, color: cs.onPrimary, size: 30),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'auth.forget.email_card_title'.tr(context),
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                color: cs.tertiary,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'auth.forget.email_card_subtitle'.tr(context),
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(
                color: cs.tertiary.withValues(alpha: 0.7),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'auth.forget.email_label'.tr(context),
              textAlign: TextAlign.start,
              style: textTheme.titleSmall?.copyWith(
                color: cs.tertiary,
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
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [cs.primaryContainer, cs.primary],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: cs.shadow.withValues(alpha: 0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: onSend,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    foregroundColor: cs.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.check, size: 18, color: cs.onPrimary),
                      const SizedBox(width: 8),
                      Text(
                        'auth.forget.send_button'.tr(context),
                        style: textTheme.titleMedium?.copyWith(
                          color: cs.onPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'auth.forget.send_helper'.tr(context),
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: cs.outline,
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
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            cs.secondaryContainer.withValues(alpha: 0.95),
            cs.secondaryContainer.withValues(alpha: 0.75),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(LucideIcons.info, size: 17, color: cs.error),
              const SizedBox(width: 4),
              Text(
                'auth.forget.security_note_title'.tr(context),
                style: textTheme.titleSmall?.copyWith(
                  color: cs.error,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'auth.forget.security_note_body'.tr(context),
            style: textTheme.bodySmall?.copyWith(
              color: cs.error.withValues(alpha: 0.85),
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
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.primaryContainer),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            child: Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: cs.shadow.withValues(alpha: 0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Icon(LucideIcons.check, color: cs.onPrimary, size: 56),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'auth.forget.success_title'.tr(context),
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
              color: cs.error,
              fontWeight: FontWeight.w500,
              fontSize: 24,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'auth.forget.success_subtitle'.tr(context),
            textAlign: TextAlign.center,
            style: textTheme.titleSmall?.copyWith(
              color: Color(0xff672146),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            email,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            style: textTheme.titleSmall?.copyWith(
              color: cs.outline,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.secondaryContainer),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'auth.forget.next_steps'.tr(context),
                      style: textTheme.titleSmall?.copyWith(
                        color: cs.tertiary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _StepLine(
                  number: 1,
                  text: 'auth.forget.next_step_1'.tr(context),
                ),
                const SizedBox(height: 7),
                _StepLine(
                  number: 2,
                  text: 'auth.forget.next_step_2'.tr(context),
                ),
                const SizedBox(height: 7),
                _StepLine(
                  number: 3,
                  text: 'auth.forget.next_step_3'.tr(context),
                ),
                const SizedBox(height: 7),
                _StepLine(
                  number: 4,
                  text: 'auth.forget.next_step_4'.tr(context),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'auth.forget.important_label'.tr(context),
                          style: textTheme.bodySmall?.copyWith(
                            color: cs.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                        TextSpan(
                          text: 'auth.forget.important_body'.tr(context),
                          style: textTheme.bodySmall?.copyWith(
                            color: cs.primary,
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
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [cs.primaryContainer, cs.primary],
              ),
            ),
            child: ElevatedButton(
              onPressed: onBackToLogin,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                elevation: 0,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                foregroundColor: cs.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'auth.forget.back_to_login'.tr(context),
                style: textTheme.titleMedium?.copyWith(
                  color: cs.onPrimary,
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
              foregroundColor: cs.primary,
              minimumSize: const Size(0, 0),
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'auth.forget.resend'.tr(context),
              style: textTheme.titleSmall?.copyWith(
                color: cs.primary,
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
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: TextStyle(
              color: cs.onPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: textTheme.bodySmall?.copyWith(
              color: cs.tertiary,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:hajj_app/shared/widgets/directional_back_arrow.dart';

class ForgetPasswordHeroHeader extends StatelessWidget {
  const ForgetPasswordHeroHeader({
    super.key,
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
    final statusBarInset = MediaQuery.paddingOf(context).top;

    return Container(
      height: height + statusBarInset,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [cs.primaryContainer, cs.primary],
        ),
      ),
      child: SafeArea(
        bottom: false,
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
                    CustomText(
                      'auth.forget.title',
                      textAlign: TextAlign.center,
                      type: CustomTextType.headlineSmall,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(color: cs.onPrimary),
                    ),
                    const SizedBox(height: 7),
                    CustomText(
                      isSent
                          ? 'auth.forget.header_sent'
                          : 'auth.forget.header_enter_email',
                      textAlign: TextAlign.center,
                      type: CustomTextType.titleSmall,
                      color: CustomTextColor.gold,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            _ForgetPasswordStepProgress(isSent: isSent),
          ],
        ),
      ),
    );
  }
}

class _ForgetPasswordStepProgress extends StatelessWidget {
  const _ForgetPasswordStepProgress({required this.isSent});

  final bool isSent;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
          CustomText(
            'auth.forget.step_indicator',
            args: {'current': isSent ? 2 : 1, 'total': 2},
            type: CustomTextType.bodySmall,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: cs.onPrimary),
          ),
        ],
      ),
    );
  }
}

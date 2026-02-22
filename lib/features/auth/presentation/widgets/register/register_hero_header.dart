import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:hajj_app/shared/widgets/directional_back_arrow.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegisterHeroHeader extends StatelessWidget {
  const RegisterHeroHeader({
    super.key,
    required this.height,
    required this.stepNumber,
    required this.onBack,
  });

  final double height;
  final int stepNumber;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final statusBarInset = MediaQuery.paddingOf(context).top;
    final subtitleKey = switch (stepNumber) {
      1 => 'auth.register.step_basic_info',
      2 => 'auth.register.step_security',
      3 => 'auth.register.step_review',
      4 => 'auth.register.step_verify',
      _ => 'auth.register.step_success',
    };

    return Container(
      height: height + statusBarInset,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    DirectionalBackArrow(
                      onPressed: onBack,
                      color: cs.onPrimary,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'auth.register.hero_title',
                          textAlign: TextAlign.center,
                          type: CustomTextType.headlineSmall,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: cs.onPrimary),
                        ),
                        const SizedBox(height: 7),
                        CustomText(
                          subtitleKey,
                          textAlign: TextAlign.center,
                          type: CustomTextType.titleSmall,
                          color: CustomTextColor.gold,
                        ),
                      ],
                    ),
                  ],
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 60,
                  height: 40,
                  child: Icon(LucideIcons.userPlus, color: cs.brandGold),
                ),
              ],
            ),
            const SizedBox(height: 24),

            RegisterStepProgress(
              stepNumber: stepNumber,
              totalSteps: 5,
              activeColor: cs.brandGold,
              completedColor: cs.brandGold,
              lineActiveColor: cs.brandGold,
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterStepProgress extends StatelessWidget {
  const RegisterStepProgress({
    super.key,
    required this.stepNumber,
    this.totalSteps = 5,
    this.activeColor,
    this.completedColor,
    this.inactiveColor,
    this.lineInactiveColor,
    this.lineActiveColor,
  });

  final int stepNumber;
  final int totalSteps;

  final Color? activeColor;
  final Color? completedColor;
  final Color? inactiveColor;
  final Color? lineInactiveColor;
  final Color? lineActiveColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final aColor = activeColor ?? cs.primary;
    final cColor = completedColor ?? cs.primary;
    final iColor = inactiveColor ?? cs.outline.withValues(alpha: .45);

    final lInactive = lineInactiveColor ?? cs.outline.withValues(alpha: .35);
    final lActive = lineActiveColor ?? cs.primary;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: cs.onPrimary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: List.generate(totalSteps * 2 - 1, (i) {
              final isCircle = i.isEven;
              final index = i ~/ 2;

              if (isCircle) {
                final step = index + 1;
                final isActive = step == stepNumber;
                final isDone = step < stepNumber;

                return _AnimatedStepCircle(
                  number: step,
                  isActive: isActive,
                  isDone: isDone,
                  activeColor: aColor,
                  doneColor: cColor,
                  inactiveColor: iColor,
                );
              } else {
                final leftStep = index + 1;
                final isFilled = leftStep < stepNumber;

                return Expanded(
                  child: _AnimatedStepLine(
                    filled: isFilled,
                    activeColor: lActive,
                    inactiveColor: lInactive,
                  ),
                );
              }
            }),
          ),
          CustomText(
            'auth.register.step_indicator',
            args: {'current': stepNumber, 'total': totalSteps},
            type: CustomTextType.bodySmall,
            color: CustomTextColor.hint,
          ),
        ],
      ),
    );
  }
}

class _AnimatedStepCircle extends StatelessWidget {
  const _AnimatedStepCircle({
    required this.number,
    required this.isActive,
    required this.isDone,
    required this.activeColor,
    required this.doneColor,
    required this.inactiveColor,
  });

  final int number;
  final bool isActive;
  final bool isDone;

  final Color activeColor;
  final Color doneColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = isActive ? activeColor : (isDone ? doneColor : inactiveColor);
    final textColor = isDone
        ? Colors.white
        : (isActive ? cs.onSurface : cs.outline);

    return AnimatedScale(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutBack,
      scale: isActive ? 1.08 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeInOut,
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bg,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    blurRadius: 14,
                    spreadRadius: 1,
                    color: activeColor.withValues(alpha: .35),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
            child: isDone
                ? Icon(
                    LucideIcons.check,
                    key: ValueKey('done-$number'),
                    size: 16,
                    color: textColor,
                  )
                : CustomText(
                    '$number',
                    key: ValueKey('num-$number'),
                    type: CustomTextType.labelSmall,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                    ),
                    translate: false,
                  ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedStepLine extends StatelessWidget {
  const _AnimatedStepLine({
    required this.filled,
    required this.activeColor,
    required this.inactiveColor,
  });

  final bool filled;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    const lineFillAlignment = AlignmentDirectional.centerStart;

    return SizedBox(
      height: 10,
      child: Stack(
        alignment: lineFillAlignment,
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: inactiveColor,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeInOut,
            alignment: lineFillAlignment,
            widthFactor: filled ? 1.0 : 0.0,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:hajj_app/shared/widgets/custom_text.dart';

/// A numbered list of steps with small coloured circle indicators.
/// Reused in register-success and forget-password-success cards.
class NumberedStepsList extends StatelessWidget {
  const NumberedStepsList({
    super.key,
    required this.steps,
    this.textColor = CustomTextColor.lightGreen,
  });

  final List<String> steps;
  final CustomTextColor textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          if (i > 0) const SizedBox(height: 7),
          _StepLine(number: i + 1, text: steps[i], textColor: textColor),
        ],
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine({
    required this.number,
    required this.text,
    required this.textColor,
  });

  final int number;
  final String text;
  final CustomTextColor textColor;

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
          child: CustomText(
            '$number',
            style: textTheme.labelSmall?.copyWith(color: cs.onPrimary),
            translate: false,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomText(
            text,
            textAlign: TextAlign.start,
            type: CustomTextType.bodySmall,
            color: textColor,
            translate: false,
          ),
        ),
      ],
    );
  }
}

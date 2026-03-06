import 'package:flutter/material.dart';
import 'package:bawabatelhajj/shared/widgets/gradient_elevated_button.dart';

class SubmitComplaintButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const SubmitComplaintButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GradientElevatedButton(
      textKey: 'complaints.create.submit_button',
      gradientColor: GradientColors.green,
      onPressed: isEnabled ? onPressed : null,
    );
  }
}

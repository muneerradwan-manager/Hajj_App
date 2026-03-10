import 'package:flutter/material.dart';
import 'package:bawabatelhajj/shared/widgets/gradient_elevated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/custom_text.dart';
import '../../cubits/create_complaint/create_complaint_cubit.dart';
import '../../cubits/create_complaint/create_complaint_state.dart';

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
    return BlocBuilder<CreateComplaintCubit, CreateComplaintState>(
      builder: (context, state) {
        final canPress =
            isEnabled && state.isFormValid && !state.isSubmitting;

        return GradientElevatedButton(
          gradientColor: GradientColors.green,
          onPressed: canPress ? onPressed : null,
          child: state.isSubmitting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const CustomText(
                  'complaints.create.submit_button',
                  color: CustomTextColor.white,
                ),
        );
      },
    );
  }
}

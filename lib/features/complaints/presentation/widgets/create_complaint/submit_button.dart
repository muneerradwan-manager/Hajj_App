import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bawabatelhajj/shared/widgets/gradient_elevated_button.dart';
import '../../cubits/create_complaint/create_complaint_cubit.dart';
import '../../cubits/create_complaint/create_complaint_state.dart';
import '../../../../../shared/widgets/custom_text.dart';

class SubmitComplaintButton extends StatelessWidget {
  const SubmitComplaintButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateComplaintCubit, CreateComplaintState>(
      builder: (context, state) {
        final canPress = state.isFormValid && !state.isSubmitting;

        return GradientElevatedButton(
          gradientColor: GradientColors.green,
          onPressed: canPress
              ? () => context.read<CreateComplaintCubit>().submit()
              : null,
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

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:bawabatelhajj/core/localization/app_localizations_setup.dart';
import 'package:bawabatelhajj/shared/widgets/custom_container.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import '../../cubits/create_complaint/create_complaint_cubit.dart';
import '../../cubits/create_complaint/create_complaint_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocBuilder<CreateComplaintCubit, CreateComplaintState>(
      builder: (context, state) {
        final textController = TextEditingController(text: state.details);
        textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length),
        );

        return CustomContainer(
          borderSide: CustomBorderSide.borderTop,
          borderColor: CustomBorderColor.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: icon + label + counter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomContainer(
                        borderRadius: 15,
                        gradientColors: [cs.primaryContainer, cs.primary],
                        padding: const EdgeInsets.all(10),
                        borderWidth: 0,
                        child: const Icon(
                          LucideIcons.messageSquare,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const CustomText(
                        'complaints.create.details_label',
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  // Counter bubble
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: CustomText(
                        '${state.details.length}/1000',
                        translate: false,
                        color: state.details.length > 1000
                            ? CustomTextColor.lightRed
                            : CustomTextColor.hint,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: textController,
                maxLength: 1000,
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  counterText: '',
                  hint: const CustomText(
                    'complaints.create.details_hint',
                    color: CustomTextColor.hint,
                  ),
                  errorText: state.detailsError?.tr(context),
                ),
                onChanged: (value) =>
                    context.read<CreateComplaintCubit>().updateDetails(value),
              ),
            ],
          ),
        );
      },
    );
  }
}

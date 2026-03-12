import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../../complaint-kinds/presentation/cubits/complaints_kinds/complaints_kinds_cubit.dart';
import '../../../../complaint-kinds/presentation/cubits/complaints_kinds/complaints_kinds_state.dart';
import '../../cubits/create_complaint/create_complaint_cubit.dart';
import '../../cubits/create_complaint/create_complaint_state.dart';

class KindsSection extends StatelessWidget {
  const KindsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocBuilder<ComplaintsKindsCubit, ComplaintsKindsState>(
      builder: (context, kindsState) {
        return BlocBuilder<CreateComplaintCubit, CreateComplaintState>(
          builder: (context, complaintState) {
            return CustomContainer(
              borderSide: CustomBorderSide.borderTop,
              borderColor: CustomBorderColor.lightGreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (kindsState.status == ComplaintKindStatus.loading) ...[
                    const LinearProgressIndicator(),
                    const SizedBox(height: 12),
                  ],

                  if (kindsState.status == ComplaintKindStatus.error)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Center(
                        child: CustomText(
                          kindsState.errorMessage,
                          translate: true,
                          color: CustomTextColor.red,
                          type: CustomTextType.labelMedium,
                        ),
                      ),
                    ),

                  const CustomText('complaints.create.kind_label'),
                  const SizedBox(height: 10),

                  Row(
                    spacing: 10,
                    children: kindsState.complaints
                        .where((e) => e.isActive)
                        .map((e) {
                          final isSelected = complaintState.kindId == e.kindId;
                          final isSuggestion = e.name == 'اقتراح';
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.read<CreateComplaintCubit>().updateKind(
                                  e.kindId,
                                );
                              },
                              child: CustomContainer(
                                hasShadow: false,
                                borderWidth: 2,
                                containerColor: isSelected
                                    ? (isSuggestion ? cs.primary : cs.brandRed)
                                    : Colors.white,
                                hasOpacity: .2,
                                borderColor: isSelected
                                    ? (isSuggestion
                                          ? CustomBorderColor.green
                                          : CustomBorderColor.red)
                                    : CustomBorderColor.hint,
                                borderHasOpacity: isSelected ? 1 : .3,
                                child: Column(
                                  spacing: 10,
                                  children: [
                                    CustomContainer(
                                      width: 48,
                                      height: 48,
                                      gradientColors: isSelected
                                          ? (isSuggestion
                                                ? [
                                                    cs.primaryContainer,
                                                    cs.primary,
                                                  ]
                                                : [cs.brandRedAlt, cs.brandRed])
                                          : [cs.outlineVariant, cs.outline],
                                      padding: EdgeInsets.zero,
                                      hasShadow: false,
                                      child: Icon(
                                        isSuggestion
                                            ? LucideIcons.lightbulb
                                            : LucideIcons.info,
                                        color: Colors.white,
                                      ),
                                    ),
                                    CustomText(
                                      e.name,
                                      color: isSelected
                                          ? (isSuggestion
                                                ? CustomTextColor.green
                                                : CustomTextColor.red)
                                          : CustomTextColor.hint,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                        .toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

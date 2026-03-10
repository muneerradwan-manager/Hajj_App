import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../../complaint-kinds/presentation/cubits/complaints_kinds/complaints_kinds_cubit.dart';
import '../../../../complaint-kinds/presentation/cubits/complaints_kinds/complaints_kinds_state.dart';

class KindsSection extends StatelessWidget {
  final int? selectedKind;
  final ValueChanged<int?> onChanged;

  const KindsSection({
    super.key,
    required this.selectedKind,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintsKindsCubit, ComplaintsKindsState>(
      builder: (context, state) {
        return CustomContainer(
          borderSide: CustomBorderSide.borderTop,
          borderColor: CustomBorderColor.lightGreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.status == ComplaintKindStatus.loading) ...[
                const LinearProgressIndicator(),
                const SizedBox(height: 12),
              ],

              if (state.status == ComplaintKindStatus.error)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CustomText(
                    state.errorMessage,
                    color: CustomTextColor.red,
                  ),
                ),

              DropdownButtonFormField<int>(
                initialValue: selectedKind,
                hint: const CustomText(
                  'complaints.create.select_kind',
                  color: CustomTextColor.hint,
                ),
                items: state.complaints
                    .where((e) => e.isActive)
                    .map(
                      (e) => DropdownMenuItem<int>(
                        value: e.kindId,
                        child: CustomText(e.name),
                      ),
                    )
                    .toList(),
                onChanged: state.status == ComplaintKindStatus.loaded
                    ? onChanged
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}

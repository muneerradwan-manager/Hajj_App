import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../../complaint-categories/presentation/cubits/complaints_categories/complaints_categories_cubit.dart';
import '../../../../complaint-categories/presentation/cubits/complaints_categories/complaints_categories_state.dart';
import '../../cubits/create_complaint/create_complaint_cubit.dart';
import '../../cubits/create_complaint/create_complaint_state.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return BlocBuilder<ComplaintsCategoriesCubit, ComplaintsCategoriesState>(
      builder: (context, categoryState) {
        return BlocBuilder<CreateComplaintCubit, CreateComplaintState>(
          builder: (context, complaintState) {
            return CustomContainer(
              borderSide: CustomBorderSide.borderTop,
              borderColor: CustomBorderColor.lightGreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (categoryState.status ==
                      ComplaintCategoryStatus.loading) ...[
                    const LinearProgressIndicator(),
                    const SizedBox(height: 12),
                  ],

                  if (categoryState.status == ComplaintCategoryStatus.error)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Center(
                        child: CustomText(
                          categoryState.errorMessage,
                          translate: true,
                          color: CustomTextColor.red,
                          type: CustomTextType.labelMedium,
                        ),
                      ),
                    ),

                  Row(
                    spacing: 10,
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
                      const CustomText('complaints.create.category_label'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<int>(
                    initialValue: complaintState.categoryId,
                    hint: const CustomText(
                      'complaints.create.select_category',
                      color: CustomTextColor.hint,
                    ),
                    items: categoryState.complaints
                        .where((e) => e.isActive)
                        .map(
                          (e) => DropdownMenuItem<int>(
                            value: e.categoryId,
                            child: CustomText(e.name),
                          ),
                        )
                        .toList(),
                    onChanged:
                        categoryState.status == ComplaintCategoryStatus.loaded
                        ? (value) {
                            context.read<CreateComplaintCubit>().updateCategory(
                              value,
                            );
                          }
                        : null,
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

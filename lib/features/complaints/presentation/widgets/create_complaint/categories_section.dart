import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../../complaint-categories/presentation/cubits/complaints_categories/complaints_categories_cubit.dart';
import '../../../../complaint-categories/presentation/cubits/complaints_categories/complaints_categories_state.dart';

class CategoriesSection extends StatelessWidget {
  final int? selectedCategory;
  final ValueChanged<int?> onChanged;

  const CategoriesSection({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintsCategoriesCubit, ComplaintsCategoriesState>(
      builder: (context, state) {
        return CustomContainer(
          borderSide: CustomBorderSide.borderTop,
          borderColor: CustomBorderColor.lightGreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.status == ComplaintCategoryStatus.loading) ...[
                const LinearProgressIndicator(),
                const SizedBox(height: 12),
              ],

              if (state.status == ComplaintCategoryStatus.error)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Center(
                    child: CustomText(
                      state.errorMessage,
                      translate: true,
                      color: CustomTextColor.red,
                      type: CustomTextType.labelMedium,
                    ),
                  ),
                ),

              DropdownButtonFormField<int>(
                initialValue: selectedCategory,
                hint: const CustomText(
                  'complaints.create.select_category',
                  color: CustomTextColor.hint,
                ),
                items: state.complaints
                    .where((e) => e.isActive)
                    .map(
                      (e) => DropdownMenuItem<int>(
                        value: e.categoryId,
                        child: CustomText(e.name),
                      ),
                    )
                    .toList(),
                onChanged: state.status == ComplaintCategoryStatus.loaded
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

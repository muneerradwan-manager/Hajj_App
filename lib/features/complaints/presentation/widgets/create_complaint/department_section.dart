import 'package:flutter/material.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';

class DepartmentSection extends StatelessWidget {
  final String? selectedDepartment;
  final ValueChanged<String?> onChanged;

  const DepartmentSection({
    super.key,
    required this.selectedDepartment,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderSide: CustomBorderSide.borderTop,
      borderColor: CustomBorderColor.lightGreen,
      child: DropdownButtonFormField<String>(
        initialValue: selectedDepartment,
        hint: const CustomText(
          'complaints.create.select_department',
          color: CustomTextColor.hint,
        ),
        items: const [
          DropdownMenuItem(
            value: 'finance',
            child: CustomText('complaints.create.department_finance'),
          ),
          DropdownMenuItem(
            value: 'hr',
            child: CustomText('complaints.create.department_hr'),
          ),
          DropdownMenuItem(
            value: 'technical',
            child: CustomText('complaints.create.department_technical'),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}

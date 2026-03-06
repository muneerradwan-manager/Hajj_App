import 'package:flutter/material.dart';

import '../../../../../core/localization/app_localizations_setup.dart';
import '../../../../../shared/widgets/custom_container.dart';

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
        items: [
          DropdownMenuItem(
            value: 'finance',
            child: Text(
              'complaints.create.department_finance'.tr(context),
            ),
          ),
          DropdownMenuItem(
            value: 'hr',
            child: Text(
              'complaints.create.department_hr'.tr(context),
            ),
          ),
          DropdownMenuItem(
            value: 'technical',
            child: Text(
              'complaints.create.department_technical'.tr(context),
            ),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/localization/app_localizations_setup.dart';
import 'package:bawabatelhajj/shared/widgets/custom_container.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

class SubjectSection extends StatelessWidget {
  final TextEditingController controller;
  final String? errorKey;
  final ValueChanged<String> onChanged;

  const SubjectSection({
    super.key,
    required this.controller,
    required this.onChanged,
    this.errorKey,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomContainer(
      borderSide: CustomBorderSide.borderTop,
      borderColor: CustomBorderColor.gold,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: cs.brandGold,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      LucideIcons.fileText,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const CustomText(
                    'complaints.create.subject_label',
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: CustomText(
                    '${controller.text.length}/150',
                    translate: false,
                    color: controller.text.length > 150
                        ? CustomTextColor.lightRed
                        : CustomTextColor.hint,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: controller,
            maxLength: 150,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              counterText: '',
              hint: const CustomText(
                'complaints.create.subject_hint',
                color: CustomTextColor.hint,
              ),
              errorText: errorKey?.tr(context),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../../../shared/widgets/gradient_elevated_button.dart';
import '../../../domain/entities/complaint.dart';

class ComplaintStatusCard extends StatelessWidget {
  final String title;
  final String category;
  final String status;
  final CustomTextColor statusColor;
  final CustomBorderColor borderColor;
  final IconData icon;
  final Complaint complaint;
  final bool translateTitle;
  final bool translateCategory;
  final String? date;

  const ComplaintStatusCard({
    super.key,
    required this.title,
    required this.category,
    required this.status,
    required this.statusColor,
    required this.borderColor,
    required this.icon,
    required this.complaint,
    this.translateTitle = true,
    this.translateCategory = true,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomContainer(
      borderSide: CustomBorderSide.borderRight,
      borderColor: borderColor,
      child: Column(
        spacing: 15,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  CustomContainer(
                    padding: const EdgeInsets.all(10),
                    borderRadius: 15,
                    containerColor: cs.primary,
                    borderWidth: 1,
                    child: Icon(icon, color: Colors.white),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(title, translate: translateTitle),
                      CustomText(
                        category,
                        translate: translateCategory,
                        type: CustomTextType.labelMedium,
                        color: CustomTextColor.gold,
                      ),
                    ],
                  ),
                ],
              ),
              CustomContainer(
                padding: const EdgeInsets.all(10),
                borderRadius: 15,
                containerColor: borderColor == CustomBorderColor.lightRed
                    ? cs.brandRed
                    : borderColor == CustomBorderColor.green
                    ? cs.primary
                    : cs.brandGold,
                hasOpacity: .1,
                borderColor: borderColor,
                borderWidth: 1,
                child: CustomText(status, color: statusColor),
              ),
            ],
          ),
          Row(
            spacing: 20,
            children: [
              Flexible(
                child: GradientElevatedButton(
                  onPressed: () => context.pushNamed(
                    AppRoutes.complaintDetailsName,
                    extra: complaint,
                  ),

                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gradientColor: GradientColors.green,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomText(
                          'complaints.action.view_details',
                          color: CustomTextColor.white,
                        ),
                      ),
                      Icon(LucideIcons.eye),
                    ],
                  ),
                ),
              ),
              if (date != null)
                Flexible(
                  child: Row(
                    spacing: 5,
                    children: [
                      Icon(LucideIcons.calendar, color: cs.outline),
                      CustomText(
                        date!,
                        translate: false,
                        color: CustomTextColor.hint,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

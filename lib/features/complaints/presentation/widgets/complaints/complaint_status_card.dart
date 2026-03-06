import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../../../shared/widgets/gradient_elevated_button.dart';

class ComplaintStatusCard extends StatelessWidget {
  final String title;
  final String category;
  final String status;
  final CustomTextColor statusColor;
  final CustomBorderColor borderColor;
  final IconData icon;
  final int complaintId;

  const ComplaintStatusCard({
    super.key,
    required this.title,
    required this.category,
    required this.status,
    required this.statusColor,
    required this.borderColor,
    required this.icon,
    required this.complaintId,
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: cs.primary,
                    ),
                    child: Icon(icon, color: Colors.white),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(title),
                      CustomText(
                        category,
                        type: CustomTextType.labelMedium,
                        color: CustomTextColor.gold,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: cs.primary),
                ),
                child: CustomText(
                  status,
                  color: statusColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GradientElevatedButton(
                  onPressed: () => context.push(
                    '${AppRoutes.complaintDetailsPath}?id=$complaintId',
                  ),
                  gradientColor: GradientColors.green,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      CustomText(
                        'complaints.action.view_details',
                        color: CustomTextColor.white,
                      ),
                      Icon(LucideIcons.eye),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

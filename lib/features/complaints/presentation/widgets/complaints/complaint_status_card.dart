import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../domain/entities/complaint.dart';
import '../../cubits/complaints/complaints_cubit.dart';

class ComplaintStatusCard extends StatelessWidget {
  final IconData icon;
  final Complaint complaint;
  final bool translateTitle;
  final bool translateCategory;
  final String? date;

  const ComplaintStatusCard({
    super.key,
    required this.icon,
    required this.complaint,
    this.translateTitle = true,
    this.translateCategory = true,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Determine colors based on complaint status
    final statusColor = complaint.statusName == 'تم الإرسال'
        ? cs.brandGold
        : complaint.statusName == 'قيد المراجعة'
        ? cs.brandRed
        : cs.primary;

    final borderColor = complaint.statusName == 'تم الإرسال'
        ? CustomBorderColor.gold
        : complaint.statusName == 'قيد المراجعة'
        ? CustomBorderColor.red
        : CustomBorderColor.green;

    final statusTextColor = complaint.statusName == 'تم الإرسال'
        ? CustomTextColor.gold
        : complaint.statusName == 'قيد المراجعة'
        ? CustomTextColor.red
        : CustomTextColor.green;

    return CustomContainer(
      borderSide: CustomBorderSide.borderRight,
      borderColor: borderColor,
      padding: const EdgeInsets.all(15),
      child: Column(
        spacing: 15,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  spacing: 10,
                  children: [
                    CustomContainer(
                      padding: const EdgeInsets.all(5),
                      borderRadius: 7.5,
                      containerColor: statusColor,
                      borderWidth: 1,
                      child: Icon(icon, color: Colors.white, size: 20),
                    ),
                    Expanded(
                      child: CustomText(
                        complaint.subject,
                        translate: translateTitle,
                        type: CustomTextType.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              CustomContainer(
                padding: const EdgeInsets.all(5),
                borderRadius: 7.5,
                containerColor: statusColor.withValues(alpha: 0.1),
                borderColor: borderColor,
                borderWidth: 1,
                child: CustomText(
                  complaint.statusName,
                  color: statusTextColor,
                  type: CustomTextType.labelMedium,
                ),
              ),
            ],
          ),
          const Divider(height: 0.1),
          Row(
            spacing: 5,
            children: [
              GestureDetector(
                onTap: () async {
                  await context.pushNamed(
                    AppRoutes.complaintDetailsName,
                    pathParameters: {'id': complaint.complaintId.toString()},
                  );
                  if (context.mounted) {
                    context.read<ComplaintsCubit>().loadComplaints();
                  }
                },
                child: CustomContainer(
                  gradientColors: [cs.primaryContainer, cs.primary],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  borderWidth: 0,
                  borderRadius: 12,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 5,
                    children: [
                      Icon(LucideIcons.eye, color: Colors.white, size: 20),
                      CustomText(
                        'complaints.action.view_details',
                        color: CustomTextColor.white,
                        type: CustomTextType.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
              if (complaint.kindName.isNotEmpty)
                CustomContainer(
                  padding: const EdgeInsets.all(5),
                  borderWidth: 0,
                  borderRadius: 10,
                  containerColor: complaint.kindName == 'شكوى'
                      ? cs.brandRed
                      : cs.primary,
                  hasOpacity: .2,
                  hasShadow: false,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 5,
                    children: [
                      Icon(
                        complaint.kindName == 'شكوى'
                            ? LucideIcons.info
                            : LucideIcons.lightbulb,
                        color: complaint.kindName == 'شكوى'
                            ? cs.brandRed
                            : cs.primary,
                        size: 20,
                      ),
                      CustomText(
                        complaint.kindName,
                        type: CustomTextType.labelSmall,
                        color: complaint.kindName == 'شكوى'
                            ? CustomTextColor.red
                            : CustomTextColor.green,
                      ),
                    ],
                  ),
                ),
              const Spacer(),
              if (complaint.createdAt.isNotEmpty && date != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 5,
                  children: [
                    Icon(LucideIcons.calendar, color: cs.outline, size: 18),
                    CustomText(
                      date!,
                      translate: false,
                      color: CustomTextColor.hint,
                      type: CustomTextType.labelSmall,
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import 'complaints_card.dart';
import 'complaint_status_card.dart';
import 'new_complaint_button.dart';

class ComplaintsListSection extends StatelessWidget {
  final int complaintId;

  const ComplaintsListSection({super.key, required this.complaintId});

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 20.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          const ComplaintsCard(),
          const SizedBox(height: 30),

          const NewComplaintButton(),
          const SizedBox(height: 30),

          ComplaintStatusCard(
            title: 'complaints.sample.ac_issue',
            category: 'complaints.category.hotel',
            status: 'complaints.status.in_review',
            statusColor: CustomTextColor.lightRed,
            borderColor: CustomBorderColor.lightRed,
            icon: LucideIcons.hotel,
            complaintId: complaintId,
          ),
          const SizedBox(height: 10),

          ComplaintStatusCard(
            title: 'complaints.sample.jamarat_crowd',
            category: 'complaints.category.rituals',
            status: 'complaints.status.resolved',
            statusColor: CustomTextColor.lightGreen,
            borderColor: CustomBorderColor.green,
            icon: LucideIcons.hotel,
            complaintId: complaintId,
          ),
          const SizedBox(height: 10),

          ComplaintStatusCard(
            title: 'complaints.sample.meal_quality',
            category: 'complaints.category.rituals',
            status: 'complaints.status.pending',
            statusColor: CustomTextColor.gold,
            borderColor: CustomBorderColor.gold,
            icon: LucideIcons.hotel,
            complaintId: complaintId,
          ),
        ],
      ),
    );
  }
}

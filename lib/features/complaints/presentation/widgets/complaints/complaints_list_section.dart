import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../../domain/entities/complaint.dart';
import '../../cubits/complaints/complaints_cubit.dart';
import '../../cubits/complaints/complaints_state.dart';
import 'complaint_status_card.dart';
import 'complaints_card.dart';
import 'new_complaint_button.dart';

class ComplaintsListSection extends StatelessWidget {
  const ComplaintsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ComplaintsCubit, ComplaintsState>(
        builder: (context, state) {
          final isFirstLoad =
              state.complaints.isEmpty &&
              (state.status == ComplaintsStatus.loading ||
                  state.status == ComplaintsStatus.initial);

          return Column(
            children: [
              ComplaintsCard(
                total: state.totalCount,
                inReview: state.inReviewCount,
                resolved: state.resolvedCount,
                pending: state.pendingCount,
              ),
              const SizedBox(height: 30),
              const NewComplaintButton(),
              const SizedBox(height: 30),
              if (isFirstLoad)
                const Center(child: CircularProgressIndicator())
              else if (state.status == ComplaintsStatus.error &&
                  state.complaints.isEmpty)
                Center(
                  child: CustomText(
                    state.errorMessage,
                    translate: true,
                    color: CustomTextColor.red,
                  ),
                )
              else ...[
                if (state.isRefreshing)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                ...state.complaints.map(
                  (complaint) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ComplaintStatusCard(
                      title: complaint.subject,
                      category: complaint.categoryName,
                      status: _statusKey(complaint.statusType),
                      statusColor: _statusTextColor(complaint.statusType),
                      borderColor: _borderColor(complaint.statusType),
                      icon: LucideIcons.fileText,
                      complaint: complaint,
                      translateTitle: false,
                      translateCategory: false,
                      date: complaint.createdDate,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  String _statusKey(ComplaintStatusType statusType) {
    switch (statusType) {
      case ComplaintStatusType.pending:
        return 'complaints.status.pending';
      case ComplaintStatusType.inReview:
        return 'complaints.status.in_review';
      case ComplaintStatusType.resolved:
        return 'complaints.status.resolved';
    }
  }

  CustomTextColor _statusTextColor(ComplaintStatusType statusType) {
    switch (statusType) {
      case ComplaintStatusType.pending:
        return CustomTextColor.gold;
      case ComplaintStatusType.inReview:
        return CustomTextColor.lightRed;
      case ComplaintStatusType.resolved:
        return CustomTextColor.lightGreen;
    }
  }

  CustomBorderColor _borderColor(ComplaintStatusType statusType) {
    switch (statusType) {
      case ComplaintStatusType.pending:
        return CustomBorderColor.gold;
      case ComplaintStatusType.inReview:
        return CustomBorderColor.lightRed;
      case ComplaintStatusType.resolved:
        return CustomBorderColor.green;
    }
  }
}

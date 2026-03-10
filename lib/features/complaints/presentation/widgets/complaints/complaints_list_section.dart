import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../shared/widgets/custom_container.dart';
import '../../../../../shared/widgets/custom_text.dart';
import '../../cubits/complaints/complaints_cubit.dart';
import '../../cubits/complaints/complaints_state.dart';
import 'complaints_card.dart';
import 'complaint_status_card.dart';
import 'new_complaint_button.dart';

class ComplaintsListSection extends StatelessWidget {
  const ComplaintsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ComplaintsCubit, ComplaintsState>(
        builder: (context, state) {
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
              if (state.status == ComplaintsStatus.loading)
                const Center(child: CircularProgressIndicator())
              else if (state.status == ComplaintsStatus.error)
                Center(
                  child: CustomText(
                    state.errorMessage,
                    translate: false,
                    color: CustomTextColor.red,
                  ),
                )
              else
                ...state.complaints.map(
                  (complaint) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ComplaintStatusCard(
                      title: complaint.subject,
                      category: complaint.categoryName,
                      status: _statusKey(complaint.status),
                      statusColor: _statusTextColor(complaint.status),
                      borderColor: _borderColor(complaint.status),
                      icon: LucideIcons.fileText,
                      complaint: complaint,
                      translateTitle: false,
                      translateCategory: false,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  String _statusKey(String status) {
    switch (status) {
      case 'تم الإرسال':
        return 'complaints.status.pending';

      case 'قيد المراجعة':
        return 'complaints.status.in_review';

      case 'تم الرد':
        return 'complaints.status.resolved';

      default:
        return 'complaints.status.pending';
    }
  }

  CustomTextColor _statusTextColor(String status) {
    switch (status) {
      case 'تم الإرسال':
        return CustomTextColor.gold;

      case 'قيد المراجعة':
        return CustomTextColor.lightRed;

      case 'تم الرد':
        return CustomTextColor.lightGreen;

      default:
        return CustomTextColor.gold;
    }
  }

  CustomBorderColor _borderColor(String status) {
    switch (status) {
      case 'تم الإرسال':
        return CustomBorderColor.gold;

      case 'قيد المراجعة':
        return CustomBorderColor.lightRed;

      case 'تم الرد':
        return CustomBorderColor.green;

      default:
        return CustomBorderColor.gold;
    }
  }
}

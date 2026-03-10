import 'package:flutter/material.dart';

import '../../../../../shared/widgets/hero_background.dart';
import '../../../domain/entities/complaint.dart';
import 'complaint_details_content_section.dart';
import 'complaint_details_hero_section.dart';

class ComplaintDetailsLayout extends StatelessWidget {
  const ComplaintDetailsLayout({super.key, required this.complaint});

  final Complaint complaint;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final viewportHeight = constraints.maxHeight;
          final viewportWidth = constraints.maxWidth;
          final viewport = MediaQuery.sizeOf(context);
          final topPadding = MediaQuery.of(context).padding.top;

          final isDesktopLayout = viewportWidth >= 1040;

          final heroHeight = isDesktopLayout
              ? (viewport.height * 0.20).clamp(300.0, 420.0)
              : (viewport.height * 0.30).clamp(260.0, 380.0) + topPadding;

          final overlap = (heroHeight * 0.22).clamp(40.0, 70.0);

          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: viewportHeight),
              child: Stack(
                children: [
                  ...HeroBackground.layers(context, heroHeight),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: heroHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ComplaintDetailsHeroSection(
                          categoryKey: complaint.categoryName,
                          createdAt: complaint.createdDate,
                          updatedAt:
                              complaint.answeredDate.isNotEmpty
                                  ? complaint.answeredDate
                                  : complaint.createdDate,
                        ),
                      ),
                      ComplaintDetailsContentSection(
                        overlap: overlap,
                        complaintId: complaint.complaintId,
                        statusType: complaint.statusType,
                        sendDate: complaint.createdDate,
                        receiveDate: complaint.closedDate.isNotEmpty
                            ? complaint.closedDate
                            : complaint.answeredDate,
                        subjectValueKey: complaint.subject,
                        fullDetailsBodyKey: complaint.message,
                        hasManagementReply: complaint.hasAnswer,
                        managementReplyBodyKey: complaint.answer ?? '',
                        attachments: complaint.attachments,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

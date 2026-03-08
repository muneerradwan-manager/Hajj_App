import 'package:flutter/material.dart';

import '../../../../../shared/widgets/hero_background.dart';
import 'complaint_details_content_section.dart';
import 'complaint_details_hero_section.dart';
import 'complaint_details_status_card.dart';

class ComplaintDetailsLayout extends StatelessWidget {
  const ComplaintDetailsLayout({super.key, required this.complaintId});

  final int complaintId;

  static const _status = ComplaintStatus.pending;
  static const _categoryKey = 'complaints.details.category_meals';
  static const _subjectValueKey =
      'complaints.details.subject_value_jamarat_crowd';
  static const _fullDetailsBodyKey = 'complaints.details.full_details_body';
  static const _replyBodyKey = 'complaints.details.management_reply_body';
  static const _createdAt = '2026-02-28';
  static const _updatedAt = '2026-03-01';
  static const _receiveDate = '2026-03-08';

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
                        child: const ComplaintDetailsHeroSection(
                          categoryKey: _categoryKey,
                          createdAt: _createdAt,
                          updatedAt: _updatedAt,
                        ),
                      ),
                      ComplaintDetailsContentSection(
                        overlap: overlap,
                        key: ValueKey('complaint-details-$complaintId'),
                        status: _status,
                        sendDate: _createdAt,
                        receiveDate: _receiveDate,
                        subjectValueKey: _subjectValueKey,
                        fullDetailsBodyKey: _fullDetailsBodyKey,
                        managementReplyBodyKey: _replyBodyKey,
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

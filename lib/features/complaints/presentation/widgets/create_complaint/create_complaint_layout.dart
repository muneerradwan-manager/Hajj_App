import 'package:flutter/material.dart';

import '../../../../../shared/widgets/hero_background.dart';
import 'create_complaint_dialog.dart';
import 'create_complaint_hero_section.dart';
import 'attachments_section.dart';
import 'department_section.dart';
import 'details_section.dart';
import 'subject_section.dart';
import 'submit_button.dart';

class CreateComplaintLayout extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController detailsController;
  final String? selectedDepartment;
  final String? subjectErrorKey;
  final String? detailsErrorKey;
  final bool isFormValid;

  final ValueChanged<String?> onDepartmentChanged;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDetailsChanged;

  const CreateComplaintLayout({
    super.key,
    required this.titleController,
    required this.detailsController,
    required this.selectedDepartment,
    required this.subjectErrorKey,
    required this.detailsErrorKey,
    required this.isFormValid,
    required this.onDepartmentChanged,
    required this.onTitleChanged,
    required this.onDetailsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.sizeOf(context);
    final topPadding = MediaQuery.of(context).padding.top;

    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportHeight = constraints.maxHeight;
        final viewportWidth = constraints.maxWidth;

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
                      child: const CreateComplaintHeroSection(),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        overlap + 20,
                        20,
                        MediaQuery.of(context).padding.bottom + 20,
                      ),
                      child: Transform.translate(
                        offset: Offset(0, -overlap),
                        child: Column(
                          children: [
                            DepartmentSection(
                              selectedDepartment: selectedDepartment,
                              onChanged: onDepartmentChanged,
                            ),

                            const SizedBox(height: 20),

                            SubjectSection(
                              controller: titleController,
                              errorKey: subjectErrorKey,
                              onChanged: onTitleChanged,
                            ),

                            const SizedBox(height: 20),

                            DetailsSection(
                              controller: detailsController,
                              errorKey: detailsErrorKey,
                              onChanged: onDetailsChanged,
                            ),

                            const SizedBox(height: 20),

                            const AttachmentsSection(),

                            const SizedBox(height: 20),

                            SubmitComplaintButton(
                              onPressed: () =>
                                  showCreateComplaintDialog(context),
                              isEnabled: isFormValid,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

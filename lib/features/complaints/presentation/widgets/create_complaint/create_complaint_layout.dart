import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widgets/custom_snackbar.dart';
import '../../../../../shared/widgets/hero_background.dart';
import '../../cubits/create_complaint/create_complaint_cubit.dart';
import '../../cubits/create_complaint/create_complaint_state.dart';

import 'create_complaint_hero_section.dart';
import 'attachments_section.dart';
import 'categories_section.dart';
import 'details_section.dart';
import 'kinds_section.dart';
import 'subject_section.dart';
import 'submit_button.dart';

class CreateComplaintLayout extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController detailsController;
  final int? selectedCategory;
  final int? selectedKind;
  final String? subjectErrorKey;
  final String? detailsErrorKey;
  final bool isFormValid;

  final ValueChanged<int?> onCategoryChanged;
  final ValueChanged<int?> onKindChanged;
  final ValueChanged<String> onSubjectChanged;
  final ValueChanged<String> onDetailsChanged;

  const CreateComplaintLayout({
    super.key,
    required this.titleController,
    required this.detailsController,
    required this.selectedCategory,
    required this.selectedKind,
    required this.subjectErrorKey,
    required this.detailsErrorKey,
    required this.isFormValid,
    required this.onCategoryChanged,
    required this.onKindChanged,
    required this.onSubjectChanged,
    required this.onDetailsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateComplaintCubit, CreateComplaintState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pop(true);
        } else if (state.status == CreateComplaintStatus.error &&
            state.errorMessage.isNotEmpty) {
          showMessage(
            context,
            state.errorMessage,
            SnackBarType.failuer,
            translate: false,
          );
        }
      },
      builder: (context, state) {
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
                            child: const Column(
                              spacing: 20,
                              children: [
                                KindsSection(),

                                CategoriesSection(),

                                SubjectSection(),

                                DetailsSection(),

                                AttachmentsSection(),

                                SubmitComplaintButton(),
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
      },
    );
  }
}

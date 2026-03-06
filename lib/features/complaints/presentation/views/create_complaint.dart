import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/core/localization/app_localizations_setup.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:bawabatelhajj/shared/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../shared/widgets/custom_container.dart';
import '../../../../shared/widgets/hero_background.dart';
import '../widgets/create_complaint_hero_section.dart';
import '../widgets/create_complaint_dialog.dart';

class CreateComplaint extends StatefulWidget {
  const CreateComplaint({super.key});

  @override
  State<CreateComplaint> createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  String? subjectErrorKey;
  String? detailsErrorKey;
  String? selectedDepartment;
  bool get isFormValid {
    return selectedDepartment != null &&
        _titleController.text.isNotEmpty &&
        _titleController.text.length <= 150 &&
        _subtitleController.text.isNotEmpty &&
        _subtitleController.text.length <= 1000;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
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
                      // HERO
                      Container(
                        height: heroHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: const CreateComplaintHeroSection(),
                      ),

                      // CONTENT
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
                              CustomContainer(
                                borderSide: CustomBorderSide.borderTop,
                                borderColor: CustomBorderColor.lightGreen,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            color: cs.primaryContainer,
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: const Icon(
                                            LucideIcons.messageSquare,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const CustomText(
                                          'complaints.create.department_label',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 15),

                                    DropdownButtonFormField<String>(
                                      initialValue: selectedDepartment,
                                      decoration: InputDecoration(
                                        hintText:
                                            'complaints.create.select_department'
                                                .tr(context),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
                                            ),
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          value: 'finance',
                                          child: Text(
                                            'complaints.create.department_finance'
                                                .tr(context),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'hr',
                                          child: Text(
                                            'complaints.create.department_hr'
                                                .tr(context),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'technical',
                                          child: Text(
                                            'complaints.create.department_technical'
                                                .tr(context),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDepartment = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomContainer(
                                borderSide: CustomBorderSide.borderTop,
                                borderColor: CustomBorderColor.gold,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: cs.brandGold,
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: const Icon(
                                                LucideIcons.fileText,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CustomText(
                                              'complaints.create.subject_label',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                        Material(
                                          elevation: 5,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: CustomText(
                                              '${_titleController.text.length}/150',
                                              translate: false,
                                              color:
                                                  _titleController.text.length >
                                                      150
                                                  ? CustomTextColor.lightRed
                                                  : CustomTextColor.hint,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: _titleController,
                                      maxLength: 150,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        counterText:
                                            '', // hides default counter
                                        hint: const CustomText(
                                          'complaints.create.subject_hint',
                                          color: CustomTextColor.hint,
                                        ),
                                        errorText: subjectErrorKey?.tr(context),
                                      ),
                                      validator: (value) {
                                        if (value != null &&
                                            value.length > 150) {
                                          return 'complaints.create.subject_max_length_error'
                                              .tr(context);
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          if (value.length > 150) {
                                            subjectErrorKey =
                                                'complaints.create.subject_max_length_error';
                                          } else {
                                            subjectErrorKey = null;
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomContainer(
                                borderSide: CustomBorderSide.borderTop,
                                borderColor: CustomBorderColor.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: cs.brandRed,
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: const Icon(
                                                LucideIcons.messageSquare,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CustomText(
                                              'complaints.create.details_label',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                        Material(
                                          elevation: 5,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: CustomText(
                                              '${_subtitleController.text.length}/1000',
                                              translate: false,
                                              color:
                                                  _subtitleController
                                                          .text
                                                          .length >
                                                      1000
                                                  ? CustomTextColor.lightRed
                                                  : CustomTextColor.hint,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: _subtitleController,
                                      maxLength: 1000,
                                      maxLines: null,
                                      minLines: 5,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        counterText:
                                            '', // hides default counter
                                        hint: const CustomText(
                                          'complaints.create.details_hint',
                                          color: CustomTextColor.hint,
                                        ),
                                        errorText: detailsErrorKey?.tr(context),
                                      ),
                                      validator: (value) {
                                        if (value != null &&
                                            value.length > 1000) {
                                          return 'complaints.create.details_max_length_error'
                                              .tr(context);
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          if (value.length > 1000) {
                                            detailsErrorKey =
                                                'complaints.create.details_max_length_error';
                                          } else {
                                            detailsErrorKey = null;
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomContainer(
                                borderSide: CustomBorderSide.borderTop,
                                borderColor: CustomBorderColor.lightGreen,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            color: cs.primaryContainer,
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: const Icon(
                                            LucideIcons.camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const CustomText(
                                          'complaints.create.attachments_label',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 15),
                                    CustomContainer(
                                      borderSide: CustomBorderSide.allBorder,
                                      borderWidth: 1.15,
                                      borderColor: CustomBorderColor.gold,
                                      gradientColors: const [
                                        Color(0xffF9F8F6),
                                        Colors.white,
                                      ],
                                      hasOpacity: .3,
                                      hasShadow: true,
                                      borderRadius: 14,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 30,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomContainer(
                                            width: 100,
                                            height: 100,
                                            hasShadow: false,
                                            containerColor: const Color(
                                              0xffD9C89E,
                                            ),
                                            hasOpacity: 0.2,
                                            child: Icon(
                                              LucideIcons.upload,
                                              color: cs.brandGold,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          const CustomText(
                                            'complaints.create.attachments_select_images',
                                            type: CustomTextType.bodyLarge,
                                          ),
                                          const SizedBox(height: 5),
                                          const CustomText(
                                            'complaints.create.attachments_formats_hint',
                                            color: CustomTextColor.hint,
                                            type: CustomTextType.labelLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              GradientElevatedButton(
                                textKey: 'complaints.create.submit_button',
                                gradientColor: GradientColors.green,
                                onPressed: isFormValid
                                    ? () => showCreateComplaintDialog(context)
                                    : null,
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
      ),
    );
  }
}

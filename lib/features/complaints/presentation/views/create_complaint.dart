import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../shared/widgets/custom_container.dart';
import '../../../../shared/widgets/hero_background.dart';
import '../widgets/create_complaint_hero_section.dart';

class CreateComplaint extends StatefulWidget {
  const CreateComplaint({super.key});

  @override
  State<CreateComplaint> createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  final TextEditingController _controller = TextEditingController();
  String? errorText;
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
                                          'القسم المعني بالشكوى',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 15),

                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        hintText: 'اختر القسم',
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
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'finance',
                                          child: Text('القسم المالي'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'hr',
                                          child: Text('الموارد البشرية'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'technical',
                                          child: Text('القسم التقني'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        print(value);
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
                                                LucideIcons.messageSquare,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const CustomText(
                                              'موضوع الشكوى',
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
                                              '${_controller.text.length}/150',
                                              color:
                                                  _controller.text.length > 150
                                                  ? CustomTextColor.lightRed
                                                  : CustomTextColor.hint,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: _controller,
                                      maxLength: 150,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        counterText:
                                            '', // hides default counter
                                        hint: const CustomText(
                                          'اكتب موضوع الشكوى',
                                          color: CustomTextColor.hint,
                                        ),
                                        errorText: errorText,
                                      ),
                                      validator: (value) {
                                        if (value != null &&
                                            value.length > 150) {
                                          return 'لا يجب أن يتجاوز النص 150 حرف';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          if (value.length > 150) {
                                            errorText =
                                                'لا يجب أن يتجاوز النص 150 حرف';
                                          } else {
                                            errorText = null;
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../shared/widgets/directional_back_arrow.dart';

class CreateComplaintHeroSection extends StatelessWidget {
  const CreateComplaintHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + 20),
        Row(
          children: [
            DirectionalBackArrow(
              color: Colors.white,
              onPressed: () {
                context.pop();
              },
            ),
            const CustomText(
              'profile.back',
              textAlign: TextAlign.center,
              type: CustomTextType.bodyLarge,
              color: CustomTextColor.white,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: .3),
            border: Border.all(color: Colors.white.withValues(alpha: .5)),
          ),
          child: IconButton(
            icon: const Icon(LucideIcons.messageSquare, color: Colors.white),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 20),
        const CustomText(
          'complaints.new_complaint',
          color: CustomTextColor.white,
          type: CustomTextType.headlineSmall,
        ),
        const SizedBox(height: 10),
        const CustomText(
          'complaints.create.hero_subtitle',
          type: CustomTextType.labelLarge,
          color: CustomTextColor.lightGold,
        ),
      ],
    );
  }
}

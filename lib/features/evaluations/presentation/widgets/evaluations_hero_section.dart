import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../../shared/widgets/directional_back_arrow.dart';

class EvaluationsHeroSection extends StatelessWidget {
  const EvaluationsHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .3),
                border: Border.all(color: Colors.white.withValues(alpha: .5)),
              ),
              child: IconButton(
                icon: const Icon(LucideIcons.star, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const CustomText(
          'تقييم مراحل الحج',
          color: CustomTextColor.white,
          type: CustomTextType.headlineSmall,
        ),
        const SizedBox(height: 10),
        const CustomText(
          'قيّم تجربتك في كل محطة',
          type: CustomTextType.labelLarge,
          color: CustomTextColor.lightGold,
        ),
      ],
    );
  }
}

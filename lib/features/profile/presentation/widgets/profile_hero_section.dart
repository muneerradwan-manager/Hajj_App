import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/shared/widgets/custom_text.dart';

import '../../../../shared/widgets/directional_back_arrow.dart';

class ProfileHeroSection extends StatelessWidget {
  const ProfileHeroSection({super.key});

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
                CustomText(
                  'profile.back',
                  textAlign: TextAlign.center,
                  type: CustomTextType.bodyLarge,
                  color: CustomTextColor.white,
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: .5),
                  ),
                  child: IconButton(
                    icon: Icon(LucideIcons.download, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: .5),
                  ),
                  child: IconButton(
                    icon: Icon(LucideIcons.share2, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        CustomText(
          'profile.digital_card_title',
          color: CustomTextColor.white,
          type: CustomTextType.headlineSmall,
        ),
        SizedBox(height: 10),
        CustomText(
          'profile.complete_info',
          type: CustomTextType.labelLarge,
          color: CustomTextColor.lightGold,
        ),
      ],
    );
  }
}

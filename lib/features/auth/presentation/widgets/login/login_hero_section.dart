import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_images.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';

class LoginHeroSection extends StatelessWidget {
  const LoginHeroSection({super.key, required this.logoSize});

  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        SizedBox(
          width: logoSize,
          height: logoSize,
          child: Hero(
            tag: 'logo',
            child: Image.asset(AppImages.logo, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 12),
        const CustomText(
          'auth.login.hero_title',
          textAlign: TextAlign.center,
          type: CustomTextType.headlineSmall,
          color: CustomTextColor.white,
        ),
        const SizedBox(height: 12),
        const CustomText(
          'app.subtitle',
          textAlign: TextAlign.center,
          type: CustomTextType.bodyLarge,
          color: CustomTextColor.lightGold,
        ),
      ],
    );
  }
}

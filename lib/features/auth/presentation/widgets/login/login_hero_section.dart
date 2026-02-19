import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_images.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';

class LoginHeroSection extends StatelessWidget {
  const LoginHeroSection({super.key, required this.logoSize});

  final double logoSize;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
        Text(
          'auth.login.hero_title'.tr(context),
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 12),
        Text(
          'app.subtitle'.tr(context),
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(color: cs.surfaceDim),
        ),
      ],
    );
  }
}

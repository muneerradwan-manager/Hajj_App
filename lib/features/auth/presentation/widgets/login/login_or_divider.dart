import 'package:flutter/material.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';

class LoginOrDivider extends StatelessWidget {
  const LoginOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(child: Divider(color: cs.primary, thickness: 1.1, height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'auth.login.or'.tr(context),
            style: textTheme.titleSmall?.copyWith(
              color: cs.primary.withValues(alpha: 0.72),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(child: Divider(color: cs.primary, thickness: 1.1, height: 1)),
      ],
    );
  }
}

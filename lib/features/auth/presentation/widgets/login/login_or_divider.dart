import 'package:flutter/material.dart';

import 'package:hajj_app/shared/widgets/custom_text.dart';

class LoginOrDivider extends StatelessWidget {
  const LoginOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(child: Divider(color: cs.primary, thickness: 1.1, height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: const CustomText(
            'auth.login.or',
            type: CustomTextType.titleSmall,
            color: CustomTextColor.lightGreen,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        Expanded(child: Divider(color: cs.primary, thickness: 1.1, height: 1)),
      ],
    );
  }
}

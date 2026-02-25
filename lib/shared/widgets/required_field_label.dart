import 'package:flutter/material.dart';

import 'package:hajj_app/shared/widgets/custom_text.dart';

/// Label row showing a translated field name followed by a red asterisk.
class RequiredFieldLabel extends StatelessWidget {
  const RequiredFieldLabel(this.textKey, {super.key});

  final String textKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          textKey,
          textAlign: TextAlign.start,
          type: CustomTextType.titleSmall,
          color: CustomTextColor.green,
        ),
        const CustomText('*', color: CustomTextColor.lightRed, translate: false),
      ],
    );
  }
}

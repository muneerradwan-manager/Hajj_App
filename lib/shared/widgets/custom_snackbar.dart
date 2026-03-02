import 'package:flutter/material.dart';
import 'package:hajj_app/core/constants/app_colors.dart';

import 'custom_text.dart';

enum SnackBarType { success, failuer, info, warning }

void showMessage(
  BuildContext context,
  String message,
  SnackBarType type, {
  bool translate = false,
}) {
  final cs = Theme.of(context).colorScheme;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: type == SnackBarType.success
            ? cs.primary
            : type == SnackBarType.failuer
            ? cs.primary
            : type == SnackBarType.info
            ? cs.brandGold
            : Colors.black,
        content: CustomText(
          message,
          translate: translate,
          color: CustomTextColor.white,
        ),
      ),
    );
}

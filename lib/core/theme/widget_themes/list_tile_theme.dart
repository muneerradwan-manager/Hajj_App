import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

ListTileThemeData buildAppListTileTheme() {
  return const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSizes.spacingMd,
      vertical: AppSizes.spacingSm,
    ),
  );
}

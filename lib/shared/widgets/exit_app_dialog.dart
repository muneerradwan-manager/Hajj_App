import 'package:flutter/material.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';

Future<bool> showExitAppDialog(BuildContext context) async {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text('app.exit_title'.tr(context)),
        content: Text('app.exit_message'.tr(context)),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text('app.cancel'.tr(context)),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text('app.exit'.tr(context)),
          ),
        ],
      );
    },
  );

  return result ?? false;
}

import 'dart:io';
import 'package:flutter/material.dart';

import 'custom_text.dart';

Future<bool> showExitAppDialog(BuildContext context) async {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const CustomText('app.exit_title'),
        content: const CustomText('app.exit_message'),
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
            child: const CustomText('app.cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
              exit(0);
            },
            child: const CustomText('app.exit'),
          ),
        ],
      );
    },
  );

  return result ?? false;
}

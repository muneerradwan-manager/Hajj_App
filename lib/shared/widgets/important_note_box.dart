import 'package:flutter/material.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';

/// A highlighted note box with a bold label + body text.
/// Used for warnings and important notices in auth cards.
class ImportantNoteBox extends StatelessWidget {
  const ImportantNoteBox({
    super.key,
    required this.labelKey,
    required this.bodyKey,
    this.textAlign = TextAlign.center,
    this.backgroundColor,
  });

  final String labelKey;
  final String bodyKey;
  final TextAlign textAlign;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: labelKey.tr(context),
              style: textTheme.titleSmall?.copyWith(color: cs.primary),
            ),
            TextSpan(
              text: bodyKey.tr(context),
              style: textTheme.bodySmall?.copyWith(color: cs.primary),
            ),
          ],
        ),
        textAlign: textAlign,
      ),
    );
  }
}

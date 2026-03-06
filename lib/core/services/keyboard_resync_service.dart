import 'dart:async';
import 'dart:ui' show ViewFocusEvent, ViewFocusState;

import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class KeyboardResyncService with WidgetsBindingObserver {
  Future<void> initialize() async {
    WidgetsBinding.instance.addObserver(this);
    await resync();
  }

  Future<void> resync() async {
    final Map<int, int>? rawState = await SystemChannels.keyboard
        .invokeMapMethod<int, int>('getKeyboardState');

    if (rawState == null) return;

    final HardwareKeyboard keyboard = HardwareKeyboard.instance;

    final Set<PhysicalKeyboardKey> frameworkPressed =
        keyboard.physicalKeysPressed;

    final Map<PhysicalKeyboardKey, LogicalKeyboardKey> enginePressed = {
      for (final entry in rawState.entries)
        PhysicalKeyboardKey(entry.key): LogicalKeyboardKey(entry.value),
    };

    final Duration timeStamp =
        SchedulerBinding.instance.currentSystemFrameTimeStamp;

    for (final physicalKey in frameworkPressed.difference(
      enginePressed.keys.toSet(),
    )) {
      final logicalKey =
          keyboard.lookUpLayout(physicalKey) ??
          LogicalKeyboardKey(physicalKey.usbHidUsage);

      keyboard.handleKeyEvent(
        KeyUpEvent(
          physicalKey: physicalKey,
          logicalKey: logicalKey,
          timeStamp: timeStamp,
          synthesized: true,
        ),
      );
    }

    for (final entry in enginePressed.entries) {
      if (frameworkPressed.contains(entry.key)) continue;

      keyboard.handleKeyEvent(
        KeyDownEvent(
          physicalKey: entry.key,
          logicalKey: entry.value,
          timeStamp: timeStamp,
          synthesized: true,
        ),
      );
    }
  }

  @override
  void didChangeViewFocus(ViewFocusEvent event) {
    if (event.state != ViewFocusState.focused) return;
    unawaited(resync());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    unawaited(resync());
  }
}

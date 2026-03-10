import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bawabatelhajj/core/app/app_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: _enableDevicePreview,
      builder: (_) => const AppView(),
    );
  }
}

bool get _enableDevicePreview {
  if (!kDebugMode) return false;
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android) {
    return false;
  }
  return true;
}

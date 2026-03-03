import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajj_app/core/bloc/app_bloc_observer.dart';
import 'package:hajj_app/core/bootstrap/app_bootstrap.dart';
import 'package:hajj_app/core/di/dependency_injection.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/core/localization/localization_cubit.dart';
import 'package:hajj_app/core/localization/localization_state.dart';
import 'package:hajj_app/core/theme/app_theme.dart';
import 'package:hajj_app/core/theme/theme_cubit.dart';
import 'package:hajj_app/core/theme/theme_state.dart';

import 'core/router/app_router.dart';

bool get _enableDevicePreview {
  if (!kDebugMode) return false;
  if (kIsWeb) return true;

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
      return false;
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await bootstrapApp();

  final app = _enableDevicePreview
      ? DevicePreview(enabled: true, builder: (_) => const MainApp())
      : const MainApp();

  runApp(app);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: getIt<ThemeCubit>()),
        BlocProvider<LocalizationCubit>.value(
          value: getIt<LocalizationCubit>(),
        ),
        
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocalizationCubit, LocalizationState>(
            builder: (context, localizationState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                debugShowMaterialGrid: false,
                builder: _enableDevicePreview ? DevicePreview.appBuilder : null,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: ThemeMode.light,
                locale: localizationState.locale,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}

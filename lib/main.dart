import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajj_app/core/bootstrap/app_bootstrap.dart';
import 'package:hajj_app/core/di/dependency_injection.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/core/localization/localization_cubit.dart';
import 'package:hajj_app/core/localization/localization_state.dart';
import 'package:hajj_app/core/theme/app_theme.dart';
import 'package:hajj_app/core/theme/theme_cubit.dart';
import 'package:hajj_app/core/theme/theme_state.dart';

import 'core/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrapApp();

  runApp(
    DevicePreview(
      enabled: kIsWeb || !(Platform.isAndroid || Platform.isIOS),
      builder: (context) => const MainApp(),
    ),
  );
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
                builder: DevicePreview.appBuilder,
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

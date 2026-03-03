import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bawabatelhajj/core/di/dependency_injection.dart';
import 'package:bawabatelhajj/core/localization/localization_cubit.dart';
import 'package:bawabatelhajj/core/theme/theme_cubit.dart';

Future<void> bootstrapApp() async {
  await dotenv.load(fileName: '.env');
  setupDependencies();

  await Future.wait([
    getIt<ThemeCubit>().loadSavedTheme(),
    getIt<LocalizationCubit>().loadSavedLocale(),
  ]);
}

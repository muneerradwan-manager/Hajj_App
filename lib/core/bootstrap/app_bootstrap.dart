import 'package:hajj_app/core/di/dependency_injection.dart';
import 'package:hajj_app/core/localization/localization_cubit.dart';
import 'package:hajj_app/core/theme/theme_cubit.dart';

Future<void> bootstrapApp() async {
  setupDependencies();

  await Future.wait([
    getIt<ThemeCubit>().loadSavedTheme(),
    getIt<LocalizationCubit>().loadSavedLocale(),
  ]);
}

import 'package:get_it/get_it.dart';
import 'package:hajj_app/core/localization/localization_cubit.dart';
import 'package:hajj_app/core/theme/theme_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  if (!getIt.isRegistered<ThemeCubit>()) {
    getIt.registerLazySingleton<ThemeCubit>(ThemeCubit.new);
  }

  if (!getIt.isRegistered<LocalizationCubit>()) {
    getIt.registerLazySingleton<LocalizationCubit>(LocalizationCubit.new);
  }
}

import 'package:get_it/get_it.dart';
import 'package:hajj_app/core/localization/localization_cubit.dart';
import 'package:hajj_app/core/theme/theme_cubit.dart';
import 'package:hajj_app/features/home/data/services/prayer_times_service_impl.dart';
import 'package:hajj_app/features/home/domain/services/prayer_times_service.dart';
import 'package:hajj_app/features/home/presentation/cubits/prayer_times_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  if (!getIt.isRegistered<ThemeCubit>()) {
    getIt.registerLazySingleton<ThemeCubit>(ThemeCubit.new);
  }

  if (!getIt.isRegistered<LocalizationCubit>()) {
    getIt.registerLazySingleton<LocalizationCubit>(LocalizationCubit.new);
  }

  if (!getIt.isRegistered<PrayerTimesService>()) {
    getIt.registerLazySingleton<PrayerTimesService>(
      PrayerTimesServiceImpl.new,
    );
  }

  if (!getIt.isRegistered<PrayerTimesCubit>()) {
    getIt.registerLazySingleton<PrayerTimesCubit>(
      () => PrayerTimesCubit(getIt<PrayerTimesService>()),
    );
  }
}

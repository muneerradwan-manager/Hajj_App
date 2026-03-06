import 'package:bawabatelhajj/features/home/data/services/prayer_times_service_impl.dart';
import 'package:bawabatelhajj/features/home/domain/services/prayer_times_service.dart';
import 'package:bawabatelhajj/features/home/presentation/cubits/prayer_times_cubit.dart';

import '../dependency_injection.dart';

void registerHomeModule() {
  getIt.registerLazySingleton<PrayerTimesService>(PrayerTimesServiceImpl.new);

  getIt.registerLazySingleton(() => PrayerTimesCubit(getIt()));
}

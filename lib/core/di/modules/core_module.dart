import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bawabatelhajj/core/localization/localization_cubit.dart';
import 'package:bawabatelhajj/core/network/dio_client.dart';
import 'package:bawabatelhajj/core/services/token_storage_service.dart';
import 'package:bawabatelhajj/core/theme/theme_cubit.dart';
import 'package:bawabatelhajj/core/services/keyboard_resync_service.dart';

import '../dependency_injection.dart';

void registerCoreModule() {
  getIt.registerLazySingleton<KeyboardResyncService>(
    () => KeyboardResyncService(),
  );

  getIt.registerLazySingleton<ThemeCubit>(ThemeCubit.new);

  getIt.registerLazySingleton<LocalizationCubit>(LocalizationCubit.new);

  getIt.registerLazySingleton<FlutterSecureStorage>(
    FlutterSecureStorage.new,
  );

  getIt.registerLazySingleton<TokenStorageService>(
    () => TokenStorageService(getIt()),
  );

  getIt.registerLazySingleton<DioClient>(
    () => DioClient(tokenStorage: getIt()),
  );
}

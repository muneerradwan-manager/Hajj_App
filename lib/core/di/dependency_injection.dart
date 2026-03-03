import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bawabatelhajj/core/localization/localization_cubit.dart';
import 'package:bawabatelhajj/core/network/dio_client.dart';
import 'package:bawabatelhajj/core/theme/theme_cubit.dart';
import 'package:bawabatelhajj/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:bawabatelhajj/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bawabatelhajj/features/auth/data/datasources/register_local_data_source.dart';
import 'package:bawabatelhajj/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/clear_register_draft_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/confirm_email_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/load_register_draft_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/login_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/resend_confirm_email_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/refresh_session_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/save_register_draft_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/submit_register_usecase.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/forget_password/forget_password_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:bawabatelhajj/features/home/data/services/prayer_times_service_impl.dart';
import 'package:bawabatelhajj/features/home/domain/services/prayer_times_service.dart';
import 'package:bawabatelhajj/features/home/presentation/cubits/prayer_times_cubit.dart';
import 'package:bawabatelhajj/shared/services/storage/token_storage_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  if (!getIt.isRegistered<ThemeCubit>()) {
    getIt.registerLazySingleton<ThemeCubit>(ThemeCubit.new);
  }

  if (!getIt.isRegistered<LocalizationCubit>()) {
    getIt.registerLazySingleton<LocalizationCubit>(LocalizationCubit.new);
  }

  if (!getIt.isRegistered<FlutterSecureStorage>()) {
    getIt.registerLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
  }

  if (!getIt.isRegistered<TokenStorageService>()) {
    getIt.registerLazySingleton<TokenStorageService>(
      () => TokenStorageService(getIt<FlutterSecureStorage>()),
    );
  }

  if (!getIt.isRegistered<DioClient>()) {
    getIt.registerLazySingleton<DioClient>(
      () => DioClient(tokenStorage: getIt<TokenStorageService>()),
    );
  }

  if (!getIt.isRegistered<AuthLocalDataSource>()) {
    getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(getIt<TokenStorageService>()),
    );
  }

  if (!getIt.isRegistered<RegisterLocalDataSource>()) {
    getIt.registerLazySingleton<RegisterLocalDataSource>(
      RegisterLocalDataSource.new,
    );
  }

  if (!getIt.isRegistered<AuthRemoteDataSource>()) {
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<DioClient>()),
    );
  }

  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        getIt<AuthRemoteDataSource>(),
        getIt<RegisterLocalDataSource>(),
        getIt<AuthLocalDataSource>(),
      ),
    );
  }

  if (!getIt.isRegistered<LoginUseCase>()) {
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<GetMeUseCase>()) {
    getIt.registerLazySingleton<GetMeUseCase>(
      () => GetMeUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<LogoutUseCase>()) {
    getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<RefreshSessionUseCase>()) {
    getIt.registerLazySingleton<RefreshSessionUseCase>(
      () => RefreshSessionUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<SubmitRegisterUseCase>()) {
    getIt.registerLazySingleton<SubmitRegisterUseCase>(
      () => SubmitRegisterUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<ConfirmEmailUseCase>()) {
    getIt.registerLazySingleton<ConfirmEmailUseCase>(
      () => ConfirmEmailUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<ResendConfirmEmailUseCase>()) {
    getIt.registerLazySingleton<ResendConfirmEmailUseCase>(
      () => ResendConfirmEmailUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<ForgotPasswordUseCase>()) {
    getIt.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<ResetPasswordUseCase>()) {
    getIt.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<SaveRegisterDraftUseCase>()) {
    getIt.registerLazySingleton<SaveRegisterDraftUseCase>(
      () => SaveRegisterDraftUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<LoadRegisterDraftUseCase>()) {
    getIt.registerLazySingleton<LoadRegisterDraftUseCase>(
      () => LoadRegisterDraftUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<ClearRegisterDraftUseCase>()) {
    getIt.registerLazySingleton<ClearRegisterDraftUseCase>(
      () => ClearRegisterDraftUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<RegisterCubit>()) {
    getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(
        getIt<SubmitRegisterUseCase>(),
        getIt<ConfirmEmailUseCase>(),
        getIt<ResendConfirmEmailUseCase>(),
        getIt<SaveRegisterDraftUseCase>(),
        getIt<LoadRegisterDraftUseCase>(),
        getIt<ClearRegisterDraftUseCase>(),
      ),
    );
  }

  if (!getIt.isRegistered<LoginCubit>()) {
    getIt.registerFactory<LoginCubit>(
      () => LoginCubit(getIt<LoginUseCase>(), getIt<LogoutUseCase>()),
    );
  }

  if (!getIt.isRegistered<MeCubit>()) {
    getIt.registerFactory<MeCubit>(() => MeCubit(getIt<GetMeUseCase>()));
  }

  if (!getIt.isRegistered<ForgetPasswordCubit>()) {
    getIt.registerFactory<ForgetPasswordCubit>(
      () => ForgetPasswordCubit(
        getIt<ForgotPasswordUseCase>(),
        getIt<ResetPasswordUseCase>(),
      ),
    );
  }

  if (!getIt.isRegistered<PrayerTimesService>()) {
    getIt.registerLazySingleton<PrayerTimesService>(PrayerTimesServiceImpl.new);
  }

  if (!getIt.isRegistered<PrayerTimesCubit>()) {
    getIt.registerLazySingleton<PrayerTimesCubit>(
      () => PrayerTimesCubit(getIt<PrayerTimesService>()),
    );
  }
}

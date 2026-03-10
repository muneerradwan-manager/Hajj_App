import 'package:bawabatelhajj/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:bawabatelhajj/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bawabatelhajj/features/auth/data/datasources/register_local_data_source.dart';
import 'package:bawabatelhajj/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bawabatelhajj/features/auth/domain/repositories/auth_repository.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/login_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/get_cached_me_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/refresh_session_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/submit_register_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/confirm_email_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/resend_confirm_email_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/save_register_draft_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/load_register_draft_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/clear_register_draft_usecase.dart';
import 'package:bawabatelhajj/features/auth/domain/usecases/update_saudi_number_usecase.dart';

import 'package:bawabatelhajj/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/me/me_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:bawabatelhajj/features/auth/presentation/cubits/forget_password/forget_password_cubit.dart';

import '../dependency_injection.dart';

void registerAuthModule() {

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt()),
  );

  getIt.registerLazySingleton<RegisterLocalDataSource>(
    RegisterLocalDataSource.new,
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt(),
      getIt(),
      getIt(),
    ),
  );

  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetMeUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCachedMeUseCase(getIt()));
  getIt.registerLazySingleton(() => RefreshSessionUseCase(getIt()));

  getIt.registerLazySingleton(() => SubmitRegisterUseCase(getIt()));
  getIt.registerLazySingleton(() => ConfirmEmailUseCase(getIt()));
  getIt.registerLazySingleton(() => ResendConfirmEmailUseCase(getIt()));

  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => ResetPasswordUseCase(getIt()));

  getIt.registerLazySingleton(() => SaveRegisterDraftUseCase(getIt()));
  getIt.registerLazySingleton(() => LoadRegisterDraftUseCase(getIt()));
  getIt.registerLazySingleton(() => ClearRegisterDraftUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateSaudiNumberUseCase(getIt()));

  getIt.registerFactory(
    () => LoginCubit(getIt(), getIt()),
  );

  getIt.registerFactory(
    () => MeCubit(getIt(), getIt(), getIt()),
  );

  getIt.registerFactory(
    () => ForgetPasswordCubit(getIt(), getIt()),
  );

  getIt.registerFactory(
    () => RegisterCubit(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );
}

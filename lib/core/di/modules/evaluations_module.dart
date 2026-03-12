import 'package:bawabatelhajj/features/evaluations/data/datasources/evaluations_remote_data_source.dart';
import 'package:bawabatelhajj/features/evaluations/data/repositories/evaluations_repository_impl.dart';
import 'package:bawabatelhajj/features/evaluations/domain/repositories/evaluations_repository.dart';
import 'package:bawabatelhajj/features/evaluations/domain/usecases/get_phases_usecase.dart';
import 'package:bawabatelhajj/features/evaluations/domain/usecases/get_unanswered_questions_usecase.dart';
import 'package:bawabatelhajj/features/evaluations/domain/usecases/submit_phase_usecase.dart';
import 'package:bawabatelhajj/features/evaluations/presentation/cubits/evaluation/evaluation_cubit.dart';
import 'package:bawabatelhajj/features/evaluations/presentation/cubits/phases/phases_cubit.dart';

import '../dependency_injection.dart';

void registerEvaluationsModule() {
  getIt.registerLazySingleton<EvaluationsRemoteDataSource>(
    () => EvaluationsRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<EvaluationsRepository>(
    () => EvaluationsRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<GetPhasesUseCase>(
    () => GetPhasesUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetUnansweredQuestionsUseCase>(
    () => GetUnansweredQuestionsUseCase(getIt()),
  );

  getIt.registerLazySingleton<SubmitPhaseUseCase>(
    () => SubmitPhaseUseCase(getIt()),
  );

  getIt.registerFactory(() => PhasesCubit(getIt()));
  getIt.registerFactory(() => EvaluationCubit(getIt(), getIt()));
}

import 'package:bawabatelhajj/features/complaint-categories/data/datasources/complaint_categories_local_data_source.dart';

import '../../../features/complaint-categories/data/datasources/complaint_categories_remote_data_source.dart';
import '../../../features/complaint-categories/data/repositories/complaint_categories_repository_impl.dart';
import '../../../features/complaint-categories/domain/repositories/complaint_categories_repository.dart';
import '../../../features/complaint-categories/domain/usecases/get_complaint_categories_usecase.dart';
import '../../../features/complaint-categories/presentation/cubits/complaints_categories/complaints_categories_cubit.dart';
import '../../../features/complaint-kinds/data/datasources/complaint_kinds_local_data_source.dart';
import '../../../features/complaint-kinds/data/datasources/complaint_kinds_remote_data_source.dart';
import '../../../features/complaint-kinds/data/repositories/complaint_kinds_repository_impl.dart';
import '../../../features/complaint-kinds/domain/repositories/complaint_kinds_repository.dart';
import '../../../features/complaint-kinds/domain/usecases/get_complaint_kinds_usecase.dart';
import '../../../features/complaint-kinds/presentation/cubits/complaints_kinds/complaints_kinds_cubit.dart';
import '../../../features/complaint-statuses/data/datasources/complaint_statuses_local_data_source.dart';
import '../../../features/complaint-statuses/data/datasources/complaint_statuses_remote_data_source.dart';
import '../../../features/complaint-statuses/data/repositories/complaint_statuses_repository_impl.dart';
import '../../../features/complaint-statuses/domain/repositories/complaint_statuses_repository.dart';
import '../../../features/complaint-statuses/domain/usecases/get_complaint_statuses_usecase.dart';
import '../../../features/complaint-statuses/presentation/cubits/complaints_statuses/complaints_statuses_cubit.dart';
import '../dependency_injection.dart';

void registerPublicModule() {
  // ComplaintsCategories
  getIt.registerLazySingleton<ComplaintCategoriesLocalDataSource>(
    () => ComplaintCategoriesLocalDataSource(),
  );
  getIt.registerLazySingleton<ComplaintCategoriesRemoteDataSource>(
    () => ComplaintCategoriesRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<ComplaintCategoriesRepository>(
    () => ComplaintCategoriesRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => GetComplaintCategoriesUseCase(getIt()));
  getIt.registerFactory(() => ComplaintsCategoriesCubit(getIt()));
  // ComplaintsKinds
  getIt.registerLazySingleton<ComplaintKindsLocalDataSource>(
    () => ComplaintKindsLocalDataSource(),
  );
  getIt.registerLazySingleton<ComplaintKindsRemoteDataSource>(
    () => ComplaintKindsRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<ComplaintKindsRepository>(
    () => ComplaintKindsRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => GetComplaintKindsUseCase(getIt()));
  getIt.registerFactory(() => ComplaintsKindsCubit(getIt()));
  // ComplaintsStatuses
  getIt.registerLazySingleton<ComplaintStatusesLocalDataSource>(
    () => ComplaintStatusesLocalDataSource(),
  );
  getIt.registerLazySingleton<ComplaintStatusesRemoteDataSource>(
    () => ComplaintStatusesRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<ComplaintStatusesRepository>(
    () => ComplaintStatusesRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => GetComplaintStatusesUseCase(getIt()));
  getIt.registerFactory(() => ComplaintStatusesCubit(getIt()));
}

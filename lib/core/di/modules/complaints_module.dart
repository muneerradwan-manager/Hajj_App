import 'package:bawabatelhajj/features/complaints/data/datasources/complaints_local_data_source.dart';
import 'package:bawabatelhajj/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:bawabatelhajj/features/complaints/data/repositories/complaints_repository_impl.dart';
import 'package:bawabatelhajj/features/complaints/domain/repositories/complaints_repository.dart';
import 'package:bawabatelhajj/features/complaints/domain/usecases/create_complaint_usecase.dart';
import 'package:bawabatelhajj/features/complaints/domain/usecases/get_complaint_details_usecase.dart';
import 'package:bawabatelhajj/features/complaints/domain/usecases/get_complaints_usecase.dart';
import 'package:bawabatelhajj/features/complaints/presentation/cubits/complaints/complaints_cubit.dart';
import 'package:bawabatelhajj/features/complaints/presentation/cubits/create_complaint/create_complaint_cubit.dart';

import '../dependency_injection.dart';

void registerComplaintsModule() {
  getIt.registerLazySingleton<ComplaintsRemoteDataSource>(
    () => ComplaintsRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<ComplaintsLocalDataSource>(
    ComplaintsLocalDataSource.new,
  );

  getIt.registerLazySingleton<ComplaintsRepository>(
    () => ComplaintsRepositoryImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton<GetComplaintsUseCase>(
    () => GetComplaintsUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetComplaintDetailsUseCase>(
    () => GetComplaintDetailsUseCase(getIt()),
  );

  getIt.registerLazySingleton<CreateComplaintUseCase>(
    () => CreateComplaintUseCase(getIt()),
  );

  getIt.registerFactory(() => ComplaintsCubit(getIt()));

  getIt.registerFactory(() => CreateComplaintCubit(getIt()));
}
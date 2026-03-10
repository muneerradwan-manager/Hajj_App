import 'package:bawabatelhajj/features/complaint-categories/domain/entities/complaint_category.dart';
import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/core/network/api_error_handler.dart';

import '../../domain/repositories/complaint_categories_repository.dart';
import '../datasources/complaint_categories_local_data_source.dart';
import '../datasources/complaint_categories_remote_data_source.dart';

class ComplaintCategoriesRepositoryImpl
    implements ComplaintCategoriesRepository {
  const ComplaintCategoriesRepositoryImpl(this._remote, this._local);

  final ComplaintCategoriesRemoteDataSource _remote;
  final ComplaintCategoriesLocalDataSource _local;

  @override
  Future<Either<Failure, List<ComplaintCategory>>>
  getAllComplaintCategories() async {
    try {
      final models = await _remote.getAllComplaintCategories();
      await _local.cacheComplaints(models);
      return right(models.map((m) => m.toEntity()).toList());
    } on Exception catch (error) {
      final failure = ApiErrorHandler.handle(error);
      if (failure is NetworkFailure) {
        final cached = await _loadCachedComplaints();
        if (cached != null) {
          return right(cached);
        }
      }
      return left(failure);
    }
  }

  Future<List<ComplaintCategory>?> _loadCachedComplaints() async {
    try {
      final cached = await _local.getCachedComplaints();
      return cached?.map((model) => model.toEntity()).toList();
    } catch (_) {
      return null;
    }
  }
}

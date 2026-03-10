import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/core/network/api_error_handler.dart';

import '../../domain/entities/complaint_status.dart';
import '../../domain/repositories/complaint_statuses_repository.dart';
import '../datasources/complaint_statuses_local_data_source.dart';
import '../datasources/complaint_statuses_remote_data_source.dart';

class ComplaintStatusesRepositoryImpl implements ComplaintStatusesRepository {
  const ComplaintStatusesRepositoryImpl(this._remote, this._local);

  final ComplaintStatusesRemoteDataSource _remote;
  final ComplaintStatusesLocalDataSource _local;

  @override
  Future<Either<Failure, List<ComplaintStatus>>> getAllComplaintStatuses() async {
    try {
      final models = await _remote.getAllComplaintStatuses();
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

  Future<List<ComplaintStatus>?> _loadCachedComplaints() async {
    try {
      final cached = await _local.getCachedComplaints();
      return cached?.map((model) => model.toEntity()).toList();
    } catch (_) {
      return null;
    }
  }
}

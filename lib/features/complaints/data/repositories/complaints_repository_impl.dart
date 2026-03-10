import 'dart:io';
import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/core/network/api_error_handler.dart';
import 'package:bawabatelhajj/features/complaints/data/datasources/complaints_local_data_source.dart';
import 'package:bawabatelhajj/features/complaints/data/datasources/complaints_remote_data_source.dart';
import 'package:bawabatelhajj/features/complaints/domain/entities/complaint.dart';
import 'package:bawabatelhajj/features/complaints/domain/repositories/complaints_repository.dart';

class ComplaintsRepositoryImpl implements ComplaintsRepository {
  const ComplaintsRepositoryImpl(this._remote, this._local);

  final ComplaintsRemoteDataSource _remote;
  final ComplaintsLocalDataSource _local;

  @override
  Future<Either<Failure, List<Complaint>>> getMyComplaints() async {
    try {
      final models = await _remote.getMyComplaints();
      await _local.cacheComplaints(models);
      return right(models.map((m) => m.toEntity()).toList());
    } on Exception catch (error) {
      final failure = ApiErrorHandler.handle(error);
      if (failure is NetworkFailure) {
        final cached = await getCachedComplaints();
        if (cached != null) {
          return right(cached);
        }
      }
      return left(failure);
    }
  }

  @override
  Future<List<Complaint>?> getCachedComplaints() async {
    try {
      final cached = await _local.getCachedComplaints();
      return cached?.map((m) => m.toEntity()).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Either<Failure, Complaint>> getComplaintDetails(int id) async {
    try {
      final model = await _remote.getComplaintDetails(id);
      await _local.cacheComplaintDetails(model);
      return right(model.toEntity());
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Complaint?> getCachedComplaintDetails(int id) async {
    try {
      final model = await _local.getCachedComplaintDetails(id);
      return model?.toEntity();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Either<Failure, String>> createComplaint({
    required int categoryId,
    required int kindId,
    required String subject,
    required String message,
    required List<File> attachments,
  }) async {
    try {
      final response = await _remote.createComplaint(
        categoryId: categoryId,
        kindId: kindId,
        subject: subject,
        message: message,
        attachments: attachments,
      );

      await _local.clearCache();

      return right(response);
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComplaint(int id) async {
    try {
      await _remote.deleteComplaint(id);
      await _local.clearCache();
      return right(null);
    } on Exception catch (error) {
      return left(ApiErrorHandler.handle(error));
    }
  }

}

import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/complaint.dart';

abstract class ComplaintsRepository {
  Future<Either<Failure, List<Complaint>>> getMyComplaints();
  Future<List<Complaint>?> getCachedComplaints();

  Future<Either<Failure, Complaint>> getComplaintDetails(int id);
  Future<Complaint?> getCachedComplaintDetails(int id);

  Future<Either<Failure, String>> createComplaint({
    required int categoryId,
    required int kindId,
    required String subject,
    required String message,
    required List<File> attachments,
  });

  Future<Either<Failure, void>> deleteComplaint(int id);
}

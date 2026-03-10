import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';

import '../entities/complaint_status.dart';

abstract class ComplaintStatusesRepository {
  Future<Either<Failure, List<ComplaintStatus>>> getAllComplaintStatuses();
}

import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';

import '../entities/complaint_status.dart';
import '../repositories/complaint_statuses_repository.dart';

class GetComplaintStatusesUseCase {
  const GetComplaintStatusesUseCase(this._repository);

  final ComplaintStatusesRepository _repository;

  Future<Either<Failure, List<ComplaintStatus>>> call() =>
      _repository.getAllComplaintStatuses();
}

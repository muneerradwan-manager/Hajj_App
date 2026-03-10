import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/complaints/domain/entities/complaint.dart';
import 'package:bawabatelhajj/features/complaints/domain/repositories/complaints_repository.dart';

class GetComplaintDetailsUseCase {
  const GetComplaintDetailsUseCase(this._repository);

  final ComplaintsRepository _repository;

  Future<Either<Failure, Complaint>> call(int id) =>
      _repository.getComplaintDetails(id);
}

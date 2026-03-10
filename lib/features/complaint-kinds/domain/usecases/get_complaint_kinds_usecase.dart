import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';

import '../entities/complaint_kind.dart';
import '../repositories/complaint_kinds_repository.dart';

class GetComplaintKindsUseCase {
  const GetComplaintKindsUseCase(this._repository);

  final ComplaintKindsRepository _repository;

  Future<Either<Failure, List<ComplaintKind>>> call() =>
      _repository.getAllComplaintKinds();
}

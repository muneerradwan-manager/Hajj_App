import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/complaints/domain/repositories/complaints_repository.dart';

class DeleteComplaintUseCase {
  const DeleteComplaintUseCase(this._repository);

  final ComplaintsRepository _repository;

  Future<Either<Failure, void>> call(int id) => _repository.deleteComplaint(id);
}

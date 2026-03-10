import 'package:dartz/dartz.dart';

import 'package:bawabatelhajj/core/errors/failures.dart';

import '../entities/complaint_kind.dart';

abstract class ComplaintKindsRepository {
  Future<Either<Failure, List<ComplaintKind>>> getAllComplaintKinds();
}

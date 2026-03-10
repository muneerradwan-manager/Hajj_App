import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:bawabatelhajj/core/errors/failures.dart';
import 'package:bawabatelhajj/features/complaints/domain/repositories/complaints_repository.dart';

class CreateComplaintUseCase {
  const CreateComplaintUseCase(this._repository);

  final ComplaintsRepository _repository;

  Future<Either<Failure, String>> call({
    required int categoryId,
    required int kindId,
    required String subject,
    required String message,
    required List<File> attachments,
  }) {
    return _repository.createComplaint(
      categoryId: categoryId,
      kindId: kindId,
      subject: subject,
      message: message,
      attachments: attachments,
    );
  }
}

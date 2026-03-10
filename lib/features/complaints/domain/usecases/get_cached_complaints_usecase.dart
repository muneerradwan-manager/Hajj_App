import 'package:bawabatelhajj/features/complaints/domain/entities/complaint.dart';
import 'package:bawabatelhajj/features/complaints/domain/repositories/complaints_repository.dart';

class GetCachedComplaintsUseCase {
  const GetCachedComplaintsUseCase(this._repository);

  final ComplaintsRepository _repository;

  Future<List<Complaint>?> call() => _repository.getCachedComplaints();
}

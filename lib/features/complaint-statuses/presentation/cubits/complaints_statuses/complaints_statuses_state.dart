import 'package:equatable/equatable.dart';

import '../../../domain/entities/complaint_status.dart';

enum ComplaintStatusesStatus { initial, loading, loaded, error }

class ComplaintStatusesState extends Equatable {
  final ComplaintStatusesStatus status;
  final List<ComplaintStatus> complaints;
  final String errorMessage;

  const ComplaintStatusesState({
    required this.status,
    required this.complaints,
    required this.errorMessage,
  });

  const ComplaintStatusesState.initial()
    : status = ComplaintStatusesStatus.initial,
      complaints = const [],
      errorMessage = '';

  int get totalCount => complaints.length;

  ComplaintStatusesState copyWith({
    ComplaintStatusesStatus? status,
    List<ComplaintStatus>? complaints,
    String? errorMessage,
  }) {
    return ComplaintStatusesState(
      status: status ?? this.status,
      complaints: complaints ?? this.complaints,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, complaints, errorMessage];
}

import 'package:equatable/equatable.dart';

import '../../../domain/entities/complaint_kind.dart';

enum ComplaintKindStatus { initial, loading, loaded, error }

class ComplaintsKindsState extends Equatable {
  final ComplaintKindStatus status;
  final List<ComplaintKind> complaints;
  final String errorMessage;

  const ComplaintsKindsState({
    required this.status,
    required this.complaints,
    required this.errorMessage,
  });

  const ComplaintsKindsState.initial()
    : status = ComplaintKindStatus.initial,
      complaints = const [],
      errorMessage = '';

  int get totalCount => complaints.length;

  ComplaintsKindsState copyWith({
    ComplaintKindStatus? status,
    List<ComplaintKind>? complaints,
    String? errorMessage,
  }) {
    return ComplaintsKindsState(
      status: status ?? this.status,
      complaints: complaints ?? this.complaints,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, complaints, errorMessage];
}

import 'package:equatable/equatable.dart';

import '../../../domain/entities/complaint.dart';

enum ComplaintDetailsStatus { initial, loading, loaded, error }

class ComplaintDetailsState extends Equatable {
  final ComplaintDetailsStatus status;
  final Complaint? complaint;
  final String errorMessage;
  final bool isRefreshing;
  final bool isDeleting;

  const ComplaintDetailsState({
    required this.status,
    this.complaint,
    this.errorMessage = '',
    this.isRefreshing = false,
    this.isDeleting = false,
  });

  const ComplaintDetailsState.initial()
      : status = ComplaintDetailsStatus.initial,
        complaint = null,
        errorMessage = '',
        isRefreshing = false,
        isDeleting = false;

  ComplaintDetailsState copyWith({
    ComplaintDetailsStatus? status,
    Complaint? complaint,
    String? errorMessage,
    bool? isRefreshing,
    bool? isDeleting,
  }) {
    return ComplaintDetailsState(
      status: status ?? this.status,
      complaint: complaint ?? this.complaint,
      errorMessage: errorMessage ?? this.errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  @override
  List<Object?> get props => [status, complaint, errorMessage, isRefreshing, isDeleting];
}

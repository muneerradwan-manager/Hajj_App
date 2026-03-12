import 'package:equatable/equatable.dart';

import 'package:bawabatelhajj/features/evaluations/domain/entities/phase.dart';

enum PhasesStatus { initial, loading, loaded, error }

class PhasesState extends Equatable {
  final PhasesStatus status;
  final List<Phase> phases;
  final String errorMessage;

  const PhasesState({
    required this.status,
    required this.phases,
    required this.errorMessage,
  });

  const PhasesState.initial()
    : status = PhasesStatus.initial,
      phases = const [],
      errorMessage = '';

  PhasesState copyWith({
    PhasesStatus? status,
    List<Phase>? phases,
    String? errorMessage,
  }) {
    return PhasesState(
      status: status ?? this.status,
      phases: phases ?? this.phases,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, phases, errorMessage];
}

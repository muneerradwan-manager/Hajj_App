import 'package:equatable/equatable.dart';

import 'package:hajj_app/features/auth/domain/entities/user_profile.dart';

enum MeStatus { initial, loading, loaded, error }

class MeState extends Equatable {
  final MeStatus status;
  final UserProfile? profile;
  final String errorMessage;

  const MeState({
    required this.status,
    this.profile,
    required this.errorMessage,
  });

  const MeState.initial()
    : status = MeStatus.initial,
      profile = null,
      errorMessage = '';

  MeState copyWith({
    MeStatus? status,
    UserProfile? profile,
    String? errorMessage,
    bool clearProfile = false,
  }) {
    return MeState(
      status: status ?? this.status,
      profile: clearProfile ? null : (profile ?? this.profile),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage];
}

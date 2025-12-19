part of 'onboard_bloc.dart';

final class OnboardState {
  OnboardState({
    this.index = 0,
    this.personalizing = false,
    this.personalized = false,
  });

  final int index;
  final bool personalizing;
  final bool personalized;

  OnboardState copyWith({
    int? index,
    bool? personalizing,
    bool? personalized,
  }) {
    return OnboardState(
      index: index ?? this.index,
      personalizing: personalizing ?? this.personalizing,
      personalized: personalized ?? this.personalized,
    );
  }
}

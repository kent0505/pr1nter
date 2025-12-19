part of 'onboard_bloc.dart';

@immutable
sealed class OnboardEvent {}

final class ChangeOnboard extends OnboardEvent {
  ChangeOnboard({required this.index});

  final int index;
}

part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionEvent {}

final class CheckSubscription extends SubscriptionEvent {}

class ProfileUpdated extends SubscriptionEvent {
  ProfileUpdated(this.profile);

  final AdaptyProfile profile;
}

final class UseFree extends SubscriptionEvent {}

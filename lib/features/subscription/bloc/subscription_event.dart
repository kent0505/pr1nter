part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionEvent {}

final class CheckSubscription extends SubscriptionEvent {}

final class SetStatus extends SubscriptionEvent {}

final class UseFree extends SubscriptionEvent {}

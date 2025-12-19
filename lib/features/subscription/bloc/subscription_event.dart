part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionEvent {}

final class CheckSubscription extends SubscriptionEvent {}

final class CheckPurchased extends SubscriptionEvent {
  CheckPurchased({required this.customerInfo});

  final CustomerInfo customerInfo;
}

final class UseFree extends SubscriptionEvent {}

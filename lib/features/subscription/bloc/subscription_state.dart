part of 'subscription_bloc.dart';

final class SubscriptionState {
  final bool subscribed;
  final int free;

  SubscriptionState({
    this.subscribed = false,
    this.free = Constants.free,
  });

  SubscriptionState copyWith({
    bool? subscribed,
    int? free,
  }) {
    return SubscriptionState(
      subscribed: subscribed ?? this.subscribed,
      free: free ?? this.free,
    );
  }
}

part of 'subscription_bloc.dart';

final class SubscriptionState {
  final bool loading;
  final bool subscribed;
  final Offering? offering;
  final int free;

  SubscriptionState({
    this.loading = false,
    this.subscribed = false,
    this.offering,
    this.free = Constants.free,
  });

  SubscriptionState copyWith({
    bool? loading,
    bool? subscribed,
    Offering? offering,
    int? free,
  }) {
    return SubscriptionState(
      loading: loading ?? this.loading,
      subscribed: subscribed ?? this.subscribed,
      offering: offering ?? this.offering,
      free: free ?? this.free,
    );
  }
}

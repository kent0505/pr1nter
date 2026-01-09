import 'package:shared_preferences/shared_preferences.dart';
import 'package:adapty_flutter/adapty_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';

abstract interface class SubscriptionRepository {
  const SubscriptionRepository();

  int getFreeDoc();
  int getFreeScan();
  Future<void> setFree(String key, int value);
  Future<void> showPaywall();
  Adapty getAdapty();
}

final class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl({
    required SharedPreferences prefs,
    required Adapty adapty,
  })  : _prefs = prefs,
        _adapty = adapty;

  final SharedPreferences _prefs;
  final Adapty _adapty;

  @override
  int getFreeDoc() {
    return _prefs.getInt(Keys.freeDoc) ?? Constants.freeDoc;
  }

  @override
  int getFreeScan() {
    return _prefs.getInt(Keys.freeScan) ?? Constants.freeScan;
  }

  @override
  Future<void> setFree(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<void> showPaywall() async {
    try {
      final paywall = await _adapty.getPaywall(placementId: 'test_paywall');
      final view = await AdaptyUI().createPaywallView(paywall: paywall);
      await view.present();
    } catch (e) {
      logger(e);
    }
  }

  @override
  Adapty getAdapty() {
    return _adapty;
  }
}

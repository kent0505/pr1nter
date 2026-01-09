import 'package:adapty_flutter/adapty_flutter.dart';

class SubscriptionManager {
  AdaptyProfile? _currentProfile;

  SubscriptionManager() {
    Adapty().didUpdateProfileStream.listen((profile) {
      _currentProfile = profile;
    });
  }

  bool hasAccess() {
    return _currentProfile?.accessLevels['premium']?.isActive ?? false;
  }
}

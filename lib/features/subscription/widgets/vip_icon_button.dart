import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/icon_btn.dart';
import '../screens/subscription_screen.dart';

class VipIconButton extends StatelessWidget {
  const VipIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconBtn(
      asset: Assets.vip,
      onPressed: () {
        PaywallScreen.open(context);
      },
    );
  }
}

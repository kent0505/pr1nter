import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/icon_btn.dart';
import '../data/subscription_repository.dart';

class VipIconButton extends StatelessWidget {
  const VipIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconBtn(
      asset: Assets.vip,
      onPressed: () {
        context.read<SubscriptionRepository>().showPaywall();
      },
    );
  }
}

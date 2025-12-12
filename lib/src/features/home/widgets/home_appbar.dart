import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/icon_btn.dart';
import '../../vip/screens/vip_icon_button.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top + 8,
        bottom: 8,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          child,
          const Spacer(),
          const SizedBox(width: 8),
          IconBtn(
            asset: Assets.info,
            onPressed: () {},
          ),
          const VipIconButton(),
        ],
      ),
    );
  }
}

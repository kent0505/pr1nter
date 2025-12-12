import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/icon_btn.dart';
import '../bloc/vip_bloc.dart';
import '../screens/vip_screen.dart';

class VipIconButton extends StatelessWidget {
  const VipIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconBtn(
      asset: Assets.vip,
      onPressed: context.read<VipBloc>().state.isVip
          ? null
          : () {
              VipScreen.open(context);
            },
    );
  }
}

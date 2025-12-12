import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/icon_btn.dart';
import '../bloc/vip_bloc.dart';
import 'vip_screen.dart';

class VipIconButton extends StatelessWidget {
  const VipIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconBtn(
      asset: Assets.settings,
      onPressed: context.read<VipBloc>().state.isVip
          ? null
          : () {
              context.push(VipScreen.routePath);
            },
    );
  }
}

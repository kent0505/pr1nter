import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/icon_btn.dart';
import '../../settings/screens/connect_screen.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
    required this.title,
    this.right,
  });

  final String title;
  final Widget? right;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top + 8,
        bottom: 8,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: 32,
              fontFamily: AppFonts.w700,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 8),
          IconBtn(
            asset: Assets.info,
            onPressed: () {
              context.push(ConnectScreen.routePath);
            },
          ),
          right ?? const SizedBox(),
        ],
      ),
    );
  }
}

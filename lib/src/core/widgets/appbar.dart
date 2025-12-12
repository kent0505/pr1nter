import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';
import '../utils.dart';
import 'icon_btn.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({
    super.key,
    this.title = '',
    this.right,
    this.rightCount = 1,
    this.child,
  });

  final String title;
  final Widget? right;
  final int rightCount;
  final Widget? child;

  final appBarSize = Constants.appBarHeight;

  @override
  Size get preferredSize => Size.fromHeight(appBarSize);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Container(
      height: appBarSize + statusBarHeight,
      padding: EdgeInsets.only(
        top: statusBarHeight,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          IconBtn(
            asset: Assets.back,
            onPressed: () {
              try {
                context.pop();
              } catch (e) {
                logger('Pop error: $e');
              }
            },
          ),
          Expanded(
            child: rightCount == 1
                ? _Title(title)
                : Row(
                    children: [
                      const SizedBox(width: 16),
                      _Title(title),
                    ],
                  ),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: appBarSize,
            width: rightCount * 52,
            child: right,
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Text(
      title,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: colors.text,
        fontSize: 18,
        fontFamily: AppFonts.w700,
        height: 1,
      ),
    );
  }
}

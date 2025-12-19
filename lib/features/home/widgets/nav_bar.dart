import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/button.dart';
import '../../scanner/screens/scanner_screen.dart';
import '../bloc/home_bloc.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    final bottom = MediaQuery.of(context).viewPadding.bottom;

    return Container(
      height: Constants.navBarHeight + bottom,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: colors.tertiary2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavBarButton(
            index: 0,
            title: 'Scanner',
            asset: Assets.scanner,
            onPressed: () async {
              await ScannerScreen.getPictures(context).then((value) {
                if (context.mounted && value.isNotEmpty) {
                  context.push(
                    ScannerScreen.routePath,
                    extra: value,
                  );
                }
              });
            },
          ),
          const _NavBarButton(
            index: 1,
            title: 'Printer',
            asset: Assets.printer,
          ),
          const _NavBarButton(
            index: 2,
            title: 'Settings',
            asset: Assets.settings,
          ),
        ],
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.index,
    required this.asset,
    required this.title,
    this.onPressed,
  });

  final int index;
  final String title;
  final String asset;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Expanded(
      child: SizedBox(
        height: 54,
        child: BlocBuilder<HomeBloc, int>(
          builder: (context, state) {
            final active = state == index;

            return Button(
              onPressed: onPressed ??
                  (active
                      ? null
                      : () {
                          context
                              .read<HomeBloc>()
                              .add(ChangePage(index: index));
                        }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgWidget(
                    asset,
                    height: 24,
                    color: active ? colors.accent : colors.text2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      color: active ? colors.accent : colors.text2,
                      fontSize: 12,
                      fontFamily: active ? AppFonts.w700 : AppFonts.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

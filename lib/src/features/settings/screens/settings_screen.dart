import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../home/widgets/home_appbar.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Column(
      children: [
        const HomeAppbar(
          child: Text(
            'Settings',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontFamily: AppFonts.w700,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SettingsTile(
                    title: 'Privacy Policy',
                    asset: Assets.settings,
                    onPressed: () async {
                      await launchURL(Urls.privacy);
                    },
                  ),
                  SettingsTile(
                    title: 'Terms of Use',
                    asset: Assets.settings,
                    onPressed: () async {
                      await launchURL(Urls.terms);
                    },
                  ),
                  SettingsTile(
                    title: 'Rate Us',
                    asset: Assets.settings,
                    onPressed: () async {},
                  ),
                  SettingsTile(
                    title: 'Share App',
                    asset: Assets.settings,
                    onPressed: () {
                      DialogWidget.show(
                        context,
                        title: 'Purchase Cancelled',
                        buttonTexts: ['OK', 'OK'],
                        buttonColors: [
                          colors.tertiary3,
                          colors.tertiary3,
                        ],
                        onPresseds: [
                          () {
                            context.pop();
                          },
                          () {
                            context.pop();
                          },
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

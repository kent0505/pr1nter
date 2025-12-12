import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../home/widgets/home_appbar.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Column(
      children: [
        HomeAppbar(
          child: Text(
            'Settings',
            style: TextStyle(
              color: colors.text,
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
                    title: 'Privacy policy',
                    asset: Assets.privacy,
                    onPressed: () async {
                      await launchURL(Urls.privacy);
                    },
                  ),
                  SettingsTile(
                    title: 'Terms & conditions',
                    asset: Assets.terms,
                    onPressed: () async {
                      await launchURL(Urls.terms);
                    },
                  ),
                  SettingsTile(
                    title: 'Share app',
                    asset: Assets.share,
                    onPressed: () async {},
                  ),
                  SettingsTile(
                    title: 'Contact us',
                    asset: Assets.contact,
                    onPressed: () async {},
                  ),
                  SettingsTile(
                    title: 'Rate us',
                    asset: Assets.star,
                    onPressed: () {
                      // DialogWidget.show(
                      //   context,
                      //   title: 'Purchase Cancelled',
                      //   buttonTexts: ['OK', 'OK'],
                      //   buttonColors: [
                      //     colors.tertiary2,
                      //     colors.tertiary2,
                      //   ],
                      //   onPresseds: [
                      //     () {
                      //       context.pop();
                      //     },
                      //     () {
                      //       context.pop();
                      //     },
                      //   ],
                      // );
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

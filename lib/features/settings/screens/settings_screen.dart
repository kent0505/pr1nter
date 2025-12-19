import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../home/widgets/home_appbar.dart';
import '../../subscription/widgets/vip_banner.dart';
import '../widgets/settings_tile.dart';
import 'connect_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeAppbar(title: 'Settings'),
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const VipBanner(),
                  SettingsTile(
                    title: 'How to connect printer?',
                    asset: Assets.connect,
                    onPressed: () {
                      context.push(ConnectScreen.routePath);
                    },
                  ),
                  const SizedBox(height: 24),
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
                    onPressed: () async {
                      await launchURL(Urls.contact);
                    },
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

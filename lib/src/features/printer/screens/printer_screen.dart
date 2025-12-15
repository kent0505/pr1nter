import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../home/widgets/home_appbar.dart';
import '../../vip/widgets/vip_icon_button.dart';
import '../widgets/printer_tile.dart';
import 'camera_screen.dart';
import 'printables_screen.dart';

class PrinterScreen extends StatelessWidget {
  const PrinterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeAppbar(
          title: 'Printer',
          right: VipIconButton(),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                PrinterTile(
                  asset: Assets.home1,
                  title: 'Documents',
                  description: 'Print documents from files',
                  onPressed: () async {
                    await pickFile().then(
                      (value) {
                        if (value.isNotEmpty && context.mounted) {
                          // context.push(
                          //   DocumentsScreen.routePath,
                          //   extra: value,
                          // );
                        }
                      },
                    );
                  },
                ),
                PrinterTile(
                  asset: Assets.home2,
                  title: 'Photos',
                  description: 'Print photos from gallery',
                  onPressed: () async {
                    await pickImage().then(
                      (value) {
                        if (value.isNotEmpty && context.mounted) {
                          context.push(
                            CameraScreen.routePath,
                            extra: value,
                          );
                        }
                      },
                    );
                  },
                ),
                PrinterTile(
                  asset: Assets.home3,
                  title: 'Email',
                  description: 'Print files from email client',
                  onPressed: () {},
                ),
                PrinterTile(
                  asset: Assets.home4,
                  title: 'Printables',
                  description: 'Print giftcards, planners, calendars',
                  onPressed: () {
                    context.push(PrintablesScreen.routePath);
                  },
                ),
                PrinterTile(
                  asset: Assets.home5,
                  title: 'Notes',
                  description: 'Enter or paste the text to print',
                  onPressed: () {},
                ),
                PrinterTile(
                  asset: Assets.home6,
                  title: 'Dropbox',
                  description: 'Print files from your account',
                  onPressed: () {},
                ),
                PrinterTile(
                  asset: Assets.home7,
                  title: 'Contacts',
                  description: 'Print any contact page',
                  onPressed: () {},
                ),
                PrinterTile(
                  asset: Assets.home8,
                  title: 'Web pages',
                  description: 'Print any website in full size',
                  onPressed: () {},
                ),
                PrinterTile(
                  asset: Assets.home9,
                  title: 'Scanner',
                  description: 'Scan any document',
                  onPressed: () {},
                ),
                PrinterTile(
                  asset: Assets.home10,
                  title: 'Google drive',
                  description: 'Print files from your account',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

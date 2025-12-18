import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../home/widgets/home_appbar.dart';
import '../models/preview.dart';
import 'notes_screen.dart';
import '../../scanner/screens/scanner_screen.dart';
import '../../vip/bloc/vip_bloc.dart';
import '../../vip/widgets/vip_icon_button.dart';
import '../widgets/printer_tile.dart';
import 'preview_screen.dart';
import 'printables_screen.dart';
import 'web_screen.dart';

class PrinterScreen extends StatefulWidget {
  const PrinterScreen({super.key});

  @override
  State<PrinterScreen> createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  void onDocument() async {
    await pickFile().then(
      (file) {
        if (file.path.isNotEmpty && mounted) {
          context.push(
            PreviewScreen.routePath,
            extra: Preview(files: [file]),
          );
        }
      },
    );
  }

  void onPhotos() async {
    await pickImages().then((files) {
      if (files.isNotEmpty && mounted) {
        context.push(
          PreviewScreen.routePath,
          extra: Preview(files: files),
        );
      }
    });
  }

  void onPrintables() {
    context.push(PrintablesScreen.routePath);
  }

  void onNotes() {
    context.push(NotesScreen.routePath);
  }

  void onWeb() {
    context.push(WebScreen.routePath);
  }

  void onDropbox() async {
    await launchURL(Urls.dropbox);
  }

  void onScanner() async {
    await ScannerScreen.getPictures(context).then((value) {
      if (mounted && value.isNotEmpty) {
        context.push(
          ScannerScreen.routePath,
          extra: value,
        );
      }
    });
  }

  void onDrive() async {
    await launchURL(Urls.drive);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VipBloc, VipState>(
      builder: (context, state) {
        final locked = state.offering != null && !state.isVip;

        return Column(
          children: [
            HomeAppbar(
              title: 'Printer',
              right: locked ? const VipIconButton() : null,
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
                      onPressed: onDocument,
                    ),
                    PrinterTile(
                      asset: Assets.home2,
                      title: 'Photos',
                      description: 'Print photos from gallery',
                      onPressed: onPhotos,
                    ),
                    // PrinterTile(
                    //   asset: Assets.home3,
                    //   title: 'Email',
                    //   description: 'Print files from email client',
                    //   onPressed: () {},
                    // ),
                    PrinterTile(
                      asset: Assets.home4,
                      title: 'Printables',
                      description: 'Print giftcards, planners, calendars',
                      locked: locked,
                      onPressed: onPrintables,
                    ),
                    PrinterTile(
                      asset: Assets.home5,
                      title: 'Notes',
                      description: 'Enter or paste the text to print',
                      locked: locked,
                      onPressed: onNotes,
                    ),
                    PrinterTile(
                      asset: Assets.home6,
                      title: 'Dropbox',
                      description: 'Print files from your account',
                      locked: locked,
                      onPressed: onDropbox,
                    ),
                    // PrinterTile(
                    //   asset: Assets.home7,
                    //   title: 'Contacts',
                    //   description: 'Print any contact page',
                    //   locked: locked,
                    //   onPressed: () {},
                    // ),
                    PrinterTile(
                      asset: Assets.home8,
                      title: 'Web pages',
                      description: 'Print any website in full size',
                      locked: locked,
                      onPressed: onWeb,
                    ),
                    PrinterTile(
                      asset: Assets.home9,
                      title: 'Scanner',
                      description: 'Scan any document',
                      // locked: locked,
                      onPressed: onScanner,
                    ),
                    PrinterTile(
                      asset: Assets.home10,
                      title: 'Google drive',
                      description: 'Print files from your account',
                      locked: locked,
                      onPressed: onDrive,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

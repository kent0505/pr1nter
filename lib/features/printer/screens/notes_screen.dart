import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/field.dart';
import '../models/preview.dart';
import 'preview_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  static const routePath = '/NotesScreen';

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final noteController = TextEditingController();

  String title = 'Default';

  void onFont(String value) {
    setState(() {
      title = value;
    });
  }

  Future<File> createTempFile(String text) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/note.txt');
    return file.writeAsString(text);
  }

  void onDone() async {
    await createTempFile(noteController.text).then((value) {
      if (mounted) {
        context.push(
          PreviewScreen.routePath,
          extra: Preview(
            files: [value],
            font: switch (title) {
              'San Francisko' => 'assets/fonts/sf.ttf',
              'Inter' => 'assets/fonts/inter.ttf',
              'Times New Roman' => 'assets/fonts/times.ttf',
              _ => 'assets/fonts/WixMadeforText-Medium.ttf',
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    final fontFamily = switch (title) {
      'San Francisko' => AppFonts.sf,
      'Inter' => AppFonts.inter,
      'Times New Roman' => AppFonts.times,
      _ => AppFonts.w500,
    };

    return Scaffold(
      appBar: Appbar(
        title: 'Notes',
        right: Button(
          onPressed: onDone,
          child: Text(
            'Done',
            style: TextStyle(
              color: colors.accent,
              fontSize: 16,
              fontFamily: AppFonts.w700,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Field(
                controller: noteController,
                hintText: 'Enter or paste any text here',
                fieldType: FieldType.multiline,
                maxLength: 200,
                fontFamily: fontFamily,
              ),
            ),
          ),
          Container(
            height: 96,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Fonts',
                    style: TextStyle(
                      color: colors.text2,
                      fontSize: 14,
                      fontFamily: AppFonts.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 36,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    children: [
                      _FontCard(
                        title: 'Default',
                        current: title,
                        fontFamily: AppFonts.w500,
                        onPressed: onFont,
                      ),
                      const SizedBox(width: 10),
                      _FontCard(
                        title: 'San Francisko',
                        current: title,
                        fontFamily: AppFonts.sf,
                        onPressed: onFont,
                      ),
                      const SizedBox(width: 10),
                      _FontCard(
                        title: 'Inter',
                        current: title,
                        fontFamily: AppFonts.inter,
                        onPressed: onFont,
                      ),
                      const SizedBox(width: 10),
                      _FontCard(
                        title: 'Times New Roman',
                        current: title,
                        fontFamily: AppFonts.times,
                        onPressed: onFont,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FontCard extends StatelessWidget {
  const _FontCard({
    required this.title,
    required this.current,
    required this.fontFamily,
    required this.onPressed,
  });

  final String title;
  final String current;
  final String fontFamily;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Button(
      minSize: 36,
      onPressed: () {
        onPressed(title);
      },
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: colors.tertiary1,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: title == current ? colors.accent : colors.tertiary1,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: 16,
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}

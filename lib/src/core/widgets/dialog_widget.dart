import 'package:flutter/material.dart';

import '../constants.dart';
import 'main_button.dart';
import 'snack_widget.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.title,
    required this.buttonTexts,
    required this.buttonColors,
    required this.onPresseds,
  });

  final String title;
  final List<String> buttonTexts;
  final List<Color?> buttonColors;
  final List<VoidCallback?> onPresseds;

  static void show(
    BuildContext context, {
    required String title,
    required List<String> buttonTexts,
    required List<Color?> buttonColors,
    required List<VoidCallback?> onPresseds,
    bool barrierDismissible = true,
  }) {
    if (buttonTexts.isEmpty ||
        buttonTexts.length > 2 ||
        buttonTexts.length != buttonColors.length &&
            buttonTexts.length != onPresseds.length) {
      return SnackWidget.show(
        context,
        message: 'Length mismatch',
      );
    }

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.2),
      barrierDismissible: barrierDismissible,
      useSafeArea: false,
      builder: (context) {
        return PopScope(
          canPop: barrierDismissible,
          child: DialogWidget(
            title: title,
            buttonTexts: buttonTexts,
            buttonColors: buttonColors,
            onPresseds: onPresseds,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Dialog(
      child: SizedBox(
        width: 270,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colors.text,
                  fontSize: 16,
                  fontFamily: AppFonts.w700,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  buttonTexts.length,
                  (index) {
                    return Expanded(
                      child: MainButton(
                        title: buttonTexts[index],
                        color: buttonTexts.length == buttonColors.length
                            ? buttonColors[index]
                            : null,
                        onPressed: buttonTexts.length == onPresseds.length
                            ? onPresseds[index]
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}

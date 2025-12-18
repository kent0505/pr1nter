import 'package:flutter/material.dart';

import '../constants.dart';

class Snack {
  static void show(
    BuildContext context,
    String message,
  ) {
    final colors = Theme.of(context).extension<MyColors>()!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: colors.text2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: colors.text,
                fontSize: 14,
                fontFamily: AppFonts.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

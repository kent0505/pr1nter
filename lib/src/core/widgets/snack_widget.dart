import 'package:flutter/material.dart';

import '../constants.dart';

class SnackWidget {
  static void show(
    BuildContext context, {
    required String message,
  }) {
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
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: colors.tertiary4,
              borderRadius: BorderRadius.circular(12),
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

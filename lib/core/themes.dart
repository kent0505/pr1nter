import 'package:flutter/material.dart';

import 'constants.dart';

class Themes {
  final bool isDark;

  Themes({required this.isDark});

  MyColors get colors {
    return isDark ? MyColors.dark() : MyColors.light();
  }

  ThemeData get theme {
    return ThemeData(
      useMaterial3: false,
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: AppFonts.w500,
      colorScheme: isDark
          ? ColorScheme.dark(
              primary: colors.text,
              secondary: colors.text2, // overscroll
              surface: colors.bg, // bg color when push
            )
          : ColorScheme.light(
              primary: colors.text,
              secondary: colors.text2,
              surface: colors.bg,
            ),

      // SCAFFOLD
      scaffoldBackgroundColor: colors.bg,

      // DIALOG
      dialogTheme: DialogThemeData(
        insetPadding: EdgeInsets.zero,
        backgroundColor: colors.tertiary2,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      // BOTTOM SHEET
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.tertiary1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.vertical(
            top: Radius.circular(16),
          ),
        ),
      ),

      // TEXTFIELD
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.accent,
        selectionColor: colors.accent,
        selectionHandleColor: colors.accent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.bg,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        hintStyle: TextStyle(
          color: colors.text2,
          fontSize: 16,
          fontFamily: AppFonts.w500,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      extensions: [colors],
    );
  }
}

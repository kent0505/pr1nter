import 'package:flutter/material.dart';

final class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.accent,
    required this.accent2,
    required this.accent3,
    required this.bg,
    required this.text,
    required this.text2,
    required this.text3,
    required this.tertiary1,
    required this.tertiary2,
    required this.gradient,
  });

  final Color accent;
  final Color accent2;
  final Color accent3;
  final Color bg;
  final Color text;
  final Color text2;
  final Color text3;
  final Color tertiary1;
  final Color tertiary2;
  final List<Color> gradient;

  factory MyColors.light() {
    return const MyColors(
      accent: Color(0xff384cff),
      accent2: Color(0xffffb800),
      accent3: Color(0xff00cf34),
      bg: Color(0xfff8fafb),
      text: Color(0xff000000),
      text2: Color(0xffc7c7c7),
      text3: Color(0xff8e8e8e),
      tertiary1: Color(0xffFFFFFF),
      tertiary2: Color(0xffFCFEFF),
      gradient: [
        Color(0xff0013C0),
        Color(0xff8E38FF),
      ],
    );
  }

  factory MyColors.dark() {
    return const MyColors(
      accent: Color(0xff384cff),
      accent2: Color(0xffffb800),
      accent3: Color(0xff00cf34),
      bg: Color(0xfff8fafb),
      text: Color(0xff000000),
      text2: Color(0xffc7c7c7),
      text3: Color(0xff8e8e8e),
      tertiary1: Color(0xffFFFFFF),
      tertiary2: Color(0xffFCFEFF),
      gradient: [
        Color(0xff0013C0),
        Color(0xff8E38FF),
      ],
    );
  }

  @override
  MyColors copyWith({
    Color? accent,
    Color? accent2,
    Color? accent3,
    Color? bg,
    Color? text,
    Color? text2,
    Color? text3,
    Color? tertiary1,
    Color? tertiary2,
    List<Color>? gradient,
  }) {
    return MyColors(
      accent: accent ?? this.accent,
      accent2: accent2 ?? this.accent2,
      accent3: accent3 ?? this.accent3,
      bg: bg ?? this.bg,
      text: text ?? this.text,
      text2: text2 ?? this.text2,
      text3: text3 ?? this.text3,
      tertiary1: tertiary1 ?? this.tertiary1,
      tertiary2: tertiary2 ?? this.tertiary2,
      gradient: gradient ?? this.gradient,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      accent: Color.lerp(accent, other.accent, t)!,
      accent2: Color.lerp(accent2, other.accent2, t)!,
      accent3: Color.lerp(accent3, other.accent3, t)!,
      bg: Color.lerp(bg, other.bg, t)!,
      text: Color.lerp(text, other.text, t)!,
      text2: Color.lerp(text2, other.text2, t)!,
      text3: Color.lerp(text3, other.text3, t)!,
      tertiary1: Color.lerp(tertiary1, other.tertiary1, t)!,
      tertiary2: Color.lerp(tertiary2, other.tertiary2, t)!,
      gradient: [
        Color.lerp(gradient.first, other.gradient.first, t)!,
        Color.lerp(gradient.last, other.gradient.last, t)!,
      ],
    );
  }
}

import 'package:flutter/material.dart';

class TextStyles {
  static const String _fontFamily = 'HarryPotter';

  static TextStyle harryPotter({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    List<Shadow>? shadows,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      shadows: shadows,
    );
  }

  static TextStyle harryPotterHeading({
    double? fontSize,
    Color? color,
    double? letterSpacing,
    List<Shadow>? shadows,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize ?? 32,
      fontWeight: FontWeight.bold,
      color: color ?? const Color(0xFFFFD700),
      letterSpacing: letterSpacing ?? 2.0,
      shadows: shadows ?? [
        const Shadow(
          color: Colors.black54,
          offset: Offset(2, 2),
          blurRadius: 4,
        ),
      ],
    );
  }

  static TextStyle harryPotterSubheading({
    double? fontSize,
    Color? color,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize ?? 18,
      fontWeight: FontWeight.w600,
      color: color ?? Colors.white70,
      letterSpacing: letterSpacing ?? 1.5,
    );
  }

  static TextStyle harryPotterBody({
    double? fontSize,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.normal,
      color: color ?? Colors.white,
      letterSpacing: letterSpacing ?? 0.5,
      height: height ?? 1.4,
    );
  }

  static TextStyle harryPotterQuote({
    double? fontSize,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize ?? 14,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
      color: color ?? Colors.white.withOpacity(0.9),
      letterSpacing: letterSpacing ?? 0.5,
      height: height ?? 1.4,
    );
  }

  static TextStyle harryPotterButton({
    double? fontSize,
    Color? color,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w600,
      color: color ?? Colors.white,
      letterSpacing: letterSpacing ?? 1.0,
    );
  }

  static TextStyle harryPotterCaption({
    double? fontSize,
    Color? color,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w400,
      color: color ?? Colors.white60,
      letterSpacing: letterSpacing ?? 0.3,
    );
  }
}
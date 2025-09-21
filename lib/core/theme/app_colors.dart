import 'package:flutter/material.dart';

class AppColors {
  // Base Colors
  static const Color black = Color(0xFF000000);
  static const Color amber = Color(0xFFFFC107);

  // Black Variations
  static const Color deepBlack = Color(0xFF0A0A0A);
  static const Color softBlack = Color(0xFF1A1A1A);
  static const Color charcoal = Color(0xFF2C2C2C);

  // Amber Variations
  static const Color lightAmber = Color(0xFFFFD54F);
  static const Color darkAmber = Color(0xFFFF8F00);
  static const Color goldenAmber = Color(0xFFFFB300);

  // Harry Potter Themed Colors
  static const Color harryPotterGold = Color(0xFFFFD700);
  static const Color harryPotterOrange = Color(0xFFFFA500);
  static const Color harryPotterBrown = Color(0xFF8B4513);
  static const Color magicalBlack = Color(0xFF0A0E27);
  static const Color darkMagical = Color(0xFF1A1B3E);

  // Background Colors
  static const Color primaryBackground = black;
  static const Color secondaryBackground = softBlack;
  static const Color cardBackground = charcoal;

  // Accent Colors
  static const Color primaryAccent = amber;
  static const Color secondaryAccent = harryPotterGold;

  // Text Colors
  static const Color primaryText = Colors.white;
  static const Color secondaryText = Colors.white70;
  static const Color accentText = amber;
  static const Color goldText = harryPotterGold;

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = amber;
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Opacity Variants
  static Color blackWithOpacity(double opacity) => black.withOpacity(opacity);
  static Color amberWithOpacity(double opacity) => amber.withOpacity(opacity);
  static Color harryPotterGoldWithOpacity(double opacity) => harryPotterGold.withOpacity(opacity);

  // Gradient Colors
  static const LinearGradient blackToAmberGradient = LinearGradient(
    colors: [black, amber],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient magicalGradient = LinearGradient(
    colors: [darkMagical, magicalBlack, black],
    stops: [0.0, 0.6, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const RadialGradient magicalRadialGradient = RadialGradient(
    center: Alignment.center,
    radius: 1.2,
    colors: [darkMagical, magicalBlack, black],
    stops: [0.0, 0.6, 1.0],
  );
}
import 'package:flutter/material.dart';

/// Centralized color palette for AutoCif DZ.
/// Primary brand color: Emerald Green (#006C4C).
class AppColors {
  AppColors._();

  static const Color primaryEmerald = Color(0xFF006C4C);
  static const Color primaryEmeraldLight = Color(0xFF2E9E7A);
  static const Color primaryEmeraldDark = Color(0xFF00432F);

  static const Color accentGold = Color(0xFFC9A227); // Algerian identity accent
  static const Color errorRed = Color(0xFFB3261E);
  static const Color warningAmber = Color(0xFFF9A825);
  static const Color successGreen = Color(0xFF2E7D32);

  static const Color surfaceLight = Color(0xFFF7F9F8);
  static const Color surfaceDark = Color(0xFF121212);

  static const Color textPrimaryLight = Color(0xFF1A1C1B);
  static const Color textPrimaryDark = Color(0xFFE2E3E1);

  // Breakdown tile category colors (calculator result screen)
  static const Color fobColor = Color(0xFF006C4C);
  static const Color freightColor = Color(0xFF1565C0);
  static const Color insuranceColor = Color(0xFF6A1B9A);
  static const Color dutyColor = Color(0xFFB3261E);
  static const Color taxColor = Color(0xFFF9A825);
  static const Color feesColor = Color(0xFF546E7A);
}
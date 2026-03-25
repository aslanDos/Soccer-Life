import 'package:flutter/material.dart';

const TextTheme appTextTheme = TextTheme(
  headlineLarge: AppTextStyle.headingLarge,
  headlineMedium: AppTextStyle.headingMedium,
  headlineSmall: AppTextStyle.headingSmall,

  titleLarge: AppTextStyle.titleLarge,
  titleMedium: AppTextStyle.titleMedium,
  titleSmall: AppTextStyle.titleSmall,

  bodyLarge: AppTextStyle.bodyLarge,
  bodyMedium: AppTextStyle.bodyMedium,
  bodySmall: AppTextStyle.bodySmall,
);

class AppTextStyle {
  AppTextStyle._();

  static const TextStyle headingLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.4,
    letterSpacing: 0.2,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );

  static const TextStyle headingXSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle titleXSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static const TextStyle bodyXSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
}

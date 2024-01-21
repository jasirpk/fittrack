// navigation_utils.dart

import 'package:flutter/material.dart';

class NavigationUtils {
  static void navigateToScreen(BuildContext context, String selectedCategory) {
    switch (selectedCategory) {
      case 'CHEST':
        navigateToChestScreen(context);
        break;
      case 'BACK':
        navigateToBackScreen(context);
        break;
      case 'BUTTOCKS':
        navigateToButtocksScreen(context);
        break;
      case 'LEGS':
        navigateToLegsScreen(context);
        break;
      case 'TRICEPS':
        navigateToTricepsScreen(context);
        break;
      case 'ABS':
        navigateToAbsScreen(context);
        break;
      case 'FOREARM':
        navigateToForearmScreen(context);
        break;
      case 'CALF':
        navigateToCalfScreen(context);
        break;
      case 'SHOULDER':
        navigateToShoulderScreen(context);
        break;
      case 'BICEPS':
        navigateToBicepsScreen(context);
      default:
    }
  }

  static void navigateToChestScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToBackScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToButtocksScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToStrecherScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToLegsScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToTricepsScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToAbsScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToForearmScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToCalfScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToShoulderScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToBicepsScreen(BuildContext context) {
    Navigator.pop(context);
  }
}

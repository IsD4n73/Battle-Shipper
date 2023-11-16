import 'package:battle_shipper/view/home/home_page.dart';
import 'package:battle_shipper/view/settings/settings_page.dart';
import 'package:flutter/material.dart';

import '../../view/splash/splash_page.dart';

class AppRoutes {
  static String splashRoute = "/";
  static String homeRoute = "/home";
  static String settingsRoute = "/settings";

  static Map<String, Widget Function(BuildContext)> routes = {
    splashRoute: (context) => const SplashPage(),
    homeRoute: (context) => const HomePage(),
    settingsRoute: (context) => const SettingsPage(),
  };
}

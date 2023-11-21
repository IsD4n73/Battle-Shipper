import 'package:flutter/material.dart';

import '../../presenter/view/home/pages/home_page.dart';
import '../../presenter/view/settings/settings_page.dart';
import '../../presenter/view/splash/splash_page.dart';
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

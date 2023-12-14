import 'package:flutter/material.dart';

import '../../presenter/view/home/pages/home_page.dart';
import '../../presenter/view/settings/settings_page.dart';

class AppRoutes {
  static String homeRoute = "/";
  static String settingsRoute = "/settings";

  static Map<String, Widget Function(BuildContext)> routes = {
    homeRoute: (context) => const HomePage(),
    settingsRoute: (context) => const SettingsPage(),
  };
}

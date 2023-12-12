import 'package:battle_shipper/common/utils/audio.dart';
import 'package:battle_shipper/common/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:username_gen/username_gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Audio.playBackground();

    SharedPreferences.getInstance().then((prefs) {
      String? user = prefs.getString('BS-username');

      user ??= UsernameGen().generate();
      prefs.setString('BS-username', user);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Image.asset("assets/images/splash-logo.png"),
      ),
    );
  }
}

import 'package:battle_shipper/common/utils/audio.dart';
import 'package:battle_shipper/common/utils/routes.dart';
import 'package:flutter/material.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const FlutterLogo();
  }
}

import 'package:battle_shipper/common/utils/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Battle Ship"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settingsRoute);
            },
            icon: const Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      body: const Placeholder(),
    );
  }
}

import 'package:battle_shipper/common/utils/routes.dart';
import 'package:battle_shipper/data/communication_manager.dart';
import 'package:flutter/material.dart';

class TestOK extends StatelessWidget {
  const TestOK({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
              "https://static.vecteezy.com/system/resources/previews/016/774/415/original/green-check-mark-icon-on-transparent-background-free-png.png"),
          const SizedBox(height: 20),
          const Text("TEST OK"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.homeRoute, (route) => false);
              Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
            },
            child: const Text("Torna alla home"),
          ),
          ElevatedButton(
            onPressed: () async {
              await CommunicationManager.conn.send("HELLOOOOO");
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }
}

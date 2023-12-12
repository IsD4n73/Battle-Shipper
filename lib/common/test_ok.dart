import 'dart:convert';
import 'dart:developer';

import 'package:battle_shipper/common/utils/routes.dart';
import 'package:battle_shipper/data/communication_manager.dart';
import 'package:battle_shipper/domain/entities/communication_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:peerdart/peerdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestOK extends StatefulWidget {
  const TestOK({super.key});

  @override
  State<TestOK> createState() => _TestOKState();
}

class _TestOKState extends State<TestOK> {
  @override
  void initState() {
    CommunicationManager.peer.on<DataConnection>("connection").listen((event) {
      CommunicationManager.conn = event;

      CommunicationManager.conn.on("data").listen((data) {
        log("TEST | DATA: $data");
        CommunicationModel communication =
            CommunicationModel.fromJson(jsonDecode(data));
        BotToast.showText(text: communication.message);
      });
    });

    super.initState();
  }

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
              var pref = await SharedPreferences.getInstance();
              var username = pref.getString('BS-username') ?? "";

              CommunicationManager.conn = CommunicationManager.peer
                  .connect(CommunicationManager.friendId);

              await Future.delayed(const Duration(seconds: 1));

              var communicatin = CommunicationModel(
                  command: "Test",
                  value: "Test",
                  peerId: CommunicationManager.peer.id!,
                  message: "HELLOOO",
                  username: username);

              await CommunicationManager.conn.send(communicatin.toString());
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }
}

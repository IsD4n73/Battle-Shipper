import 'dart:convert';
import 'dart:developer';

import 'package:battle_shipper/data/communication_manager.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:peerdart/peerdart.dart';

import '../../../../common/test_ok.dart';
import '../../../../common/theme/app_color.dart';
import '../../../../common/utils/enums.dart';
import '../../widget/battle_ship_secondary_button.dart';

class CreateLobby extends StatefulWidget {
  const CreateLobby({super.key});

  @override
  State<CreateLobby> createState() => _CreateLobbyState();
}

class _CreateLobbyState extends State<CreateLobby> {
  String joinCode = CommunicationManager.getConnectionCode();
  bool isConnected = false;

  @override
  void initState() {
    setState(() {
      CommunicationManager.peer =
          Peer(id: CommunicationManager.suffixCode + joinCode);
    });

    CommunicationManager.peer.on("close").listen((id) {
      log("Create | Peer chiuso");
      isConnected = false;
      setState(() {});
    });

    CommunicationManager.peer.on("open").listen((id) {
      log("Create | Peer aperto con id: $id");
    });

    CommunicationManager.peer.on<DataConnection>("connection").listen((event) {
      setState(() {
        CommunicationManager.conn = event;
      });

      CommunicationManager.conn.on("data").listen((data) {
        log("Create | DATA: $data");
        if ((data as String).contains("Connessione Riuscita!")) {
          setState(() {
            isConnected = true;
            CommunicationManager.conn =
                CommunicationManager.peer.connect(data.split("!").last);
          });
        }
      });

      CommunicationManager.conn.on("close").listen((event) {
        log("Create | Connessione chiusa");
        isConnected = false;
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Battle Ship"),
        centerTitle: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: joinCode));
                  BotToast.showText(text: "Codice Copiato!");
                },
                child: Text(
                  joinCode,
                  style: const TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1200.ms, color: const Color(0xFF80DDFF))
                  .animate(),
              const Text(
                "Clicca sul codice per copiarlo",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                "Dai questo codice a chi vuoi far connettere",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Status: '),
                    isConnected
                        ? const TextSpan(
                            text: 'Connected',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          )
                        : const TextSpan(
                            text: 'Waiting...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
              BattleShipSecondaryButton(
                text: "Continue",
                buttonType: BattleShipButtonType.light,
                onPressed: isConnected
                    ? () async {
                        await CommunicationManager.conn.send("Siamo Connessi!");
                        log("Create | Messaggio di risposta inviato");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TestOK(),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

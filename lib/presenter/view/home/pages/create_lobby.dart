import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:battle_shipper/data/communication_manager.dart';
import 'package:battle_shipper/domain/entities/communication_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:peerdart/peerdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/test_ok.dart';
import '../../../../common/theme/app_color.dart';
import '../../../../common/utils/enums.dart';
import '../../../../common/utils/key_const.dart';
import '../../widget/battle_ship_secondary_button.dart';

class CreateLobby extends StatefulWidget {
  const CreateLobby({super.key});

  @override
  State<CreateLobby> createState() => _CreateLobbyState();
}

class _CreateLobbyState extends State<CreateLobby> {
  String joinCode = CommunicationManager.getConnectionCode();
  String username = "";
  bool isConnected = false;
  late StreamSubscription<DataConnection> listner;

  @override
  void initState() {
    setState(() {
      CommunicationManager.peer =
          Peer(id: CommunicationManager.suffixCode + joinCode);
    });

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        username = prefs.getString(KeyConst.sharedUsername) ?? "";
      });
    });

    listner = CommunicationManager.peer
        .on<DataConnection>("connection")
        .listen((event) {
      setState(() {
        CommunicationManager.conn = event;
      });

      CommunicationManager.conn.on("data").listen((data) {
        log("Create | DATA: $data");
        var communication = CommunicationModel.fromJson(jsonDecode(data));
        CommunicationManager.friendId = communication.peerId;
        if (communication.message == "Connessione Riuscita!") {
          setState(() {
            isConnected = true;
            CommunicationManager.conn =
                CommunicationManager.peer.connect(communication.peerId);
          });
        }
      });

      CommunicationManager.conn.on("close").listen((event) {
        log("Create | Connessione chiusa");
        isConnected = false;
        setState(() {});
      });
    });

    CommunicationManager.peer.on("close").listen((id) {
      log("Create | Peer chiuso");
    });

    CommunicationManager.peer.on("open").listen((id) {
      log("Create | Peer aperto con id: $id");
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
              Text(
                "Username: $username",
                style: const TextStyle(
                  color: AppColor.terziaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: joinCode));
                  BotToast.showText(text: "Codice Copiato!".tr());
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
              Text(
                "Clicca sul codice per copiarlo".tr(),
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                "Dai questo codice a chi vuoi far connettere".tr(),
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Status: '.tr()),
                    isConnected
                        ? TextSpan(
                            text: 'Connected'.tr(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryColor,
                            ),
                          )
                        : TextSpan(
                            text: 'Waiting...'.tr(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
              BattleShipSecondaryButton(
                text: "Continue".tr(),
                buttonType: BattleShipButtonType.light,
                onPressed: isConnected
                    ? () async {
                        await CommunicationManager.conn.send(CommunicationModel(
                          command: "connection",
                          value: "OK",
                          peerId: CommunicationManager.peer.id!,
                          message: "Siamo Connessi!",
                          username: username,
                        ).toString());

                        listner.cancel();

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

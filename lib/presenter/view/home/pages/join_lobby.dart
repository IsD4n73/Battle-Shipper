import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:battle_shipper/common/theme/app_color.dart';
import 'package:battle_shipper/data/communication_manager.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peerdart/peerdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/test_ok.dart';
import '../../../../common/utils/enums.dart';
import '../../../../common/utils/key_const.dart';
import '../../../../domain/entities/communication_model.dart';
import '../../widget/battle_ship_secondary_button.dart';

class JoinLobby extends StatefulWidget {
  const JoinLobby({super.key});

  @override
  State<JoinLobby> createState() => _JoinLobbyState();
}

class _JoinLobbyState extends State<JoinLobby> {
  final TextEditingController _textController = TextEditingController();
  String username = "";
  late StreamSubscription<DataConnection> listner;
  void Function()? cancelLoading;

  @override
  void initState() {
    setState(() {
      CommunicationManager.peer = Peer(
          id: CommunicationManager.suffixCode +
              CommunicationManager.getConnectionCode());
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
        log("Join | DATA: $data");
        var communication = CommunicationModel.fromJson(jsonDecode(data));
        CommunicationManager.friendId = communication.peerId;
        if (communication.message == "Siamo Connessi!") {
          cancelLoading!();
          CommunicationManager.conn =
              CommunicationManager.peer.connect(communication.peerId);
          listner.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TestOK(),
            ),
          );
        }
      });

      CommunicationManager.conn.on("close").listen((event) {
        log("Join | Connessione chiusa");
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "Username: $username",
              style: const TextStyle(
                color: AppColor.terziaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              cursorColor: AppColor.terziaryColor,
              keyboardType: TextInputType.number,
              controller: _textController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      ClipboardData? cdata =
                          await Clipboard.getData(Clipboard.kTextPlain);
                      final numeric = RegExp(r'^[0-9]*$');

                      if (cdata != null && numeric.hasMatch(cdata.text ?? "")) {
                        setState(() {
                          _textController.text = cdata.text!;
                        });
                      }
                    },
                    icon: const Icon(Icons.paste)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                label: Text(
                  "Codice Invito".tr(),
                  style: const TextStyle(
                    color: AppColor.primaryColor,
                  ),
                ),
                hintText: "Inserisci il codice d'invito".tr(),
              ),
            ),
            const SizedBox(height: 20),
            BattleShipSecondaryButton(
              text: "Continue".tr(),
              buttonType: BattleShipButtonType.light,
              onPressed: () async {
                final numeric = RegExp(r'^[0-9]*$');
                if (_textController.text.isNotEmpty &&
                    numeric.hasMatch(_textController.text)) {
                  CommunicationManager.conn = CommunicationManager.peer.connect(
                      CommunicationManager.suffixCode + _textController.text);

                  await Future.delayed(const Duration(seconds: 1));

                  await CommunicationManager.conn.send(CommunicationModel(
                    command: "connection",
                    value: "OK",
                    peerId: CommunicationManager.peer.id!,
                    message: "Connessione Riuscita!",
                    username: username,
                  ).toString());

                  cancelLoading = BotToast.showCustomLoading(
                    toastBuilder: (cancelFunc) => Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 20),
                        BattleShipSecondaryButton(
                          onPressed: () {
                            CommunicationManager.conn.dispose();
                            CommunicationManager.peer.dispose();
                            CommunicationManager.peer = Peer(
                                id: CommunicationManager.suffixCode +
                                    CommunicationManager.getConnectionCode());
                            setState(() {});
                            cancelFunc();
                          },
                          text: "Cancel".tr(),
                          buttonType: BattleShipButtonType.dark,
                        ),
                      ],
                    ),
                  );
                  setState(() {});
                } else {
                  BotToast.showText(text: "Inserisci il codice di invito".tr());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

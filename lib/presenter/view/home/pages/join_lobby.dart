import 'dart:developer';

import 'package:battle_shipper/common/theme/app_color.dart';
import 'package:battle_shipper/data/communication_manager.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peerdart/peerdart.dart';

import '../../../../common/test_ok.dart';
import '../../../../common/utils/enums.dart';
import '../../widget/battle_ship_secondary_button.dart';

class JoinLobby extends StatefulWidget {
  const JoinLobby({super.key});

  @override
  State<JoinLobby> createState() => _JoinLobbyState();
}

class _JoinLobbyState extends State<JoinLobby> {
  final TextEditingController _textController = TextEditingController();
  void Function()? cancelLoading;

  @override
  void initState() {
    setState(() {
      CommunicationManager.peer = Peer();
    });

    CommunicationManager.peer.on("open").listen((id) {
      log("Join | Peer aperto con id: $id");
    });

    CommunicationManager.peer.on("close").listen((id) {
      log("Join | Peer chiuso");
    });

    CommunicationManager.peer.on<DataConnection>("connection").listen((event) {
      setState(() {
        CommunicationManager.conn = event;
      });

      CommunicationManager.conn.on("data").listen((data) {
        log("Join | DATA: $data");
        if (data == "Siamo Connessi!") {
          cancelLoading!();
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
                label: const Text(
                  "Codice Invito",
                  style: TextStyle(
                    color: AppColor.primaryColor,
                  ),
                ),
                hintText: "Inserisci il codice d'invito",
              ),
            ),
            const SizedBox(height: 20),
            BattleShipSecondaryButton(
              text: "Continue",
              buttonType: BattleShipButtonType.light,
              onPressed: () async {
                final numeric = RegExp(r'^[0-9]*$');
                if (_textController.text.isNotEmpty &&
                    numeric.hasMatch(_textController.text)) {
                  CommunicationManager.conn = CommunicationManager.peer.connect(
                      CommunicationManager.suffixCode + _textController.text);

                  await Future.delayed(const Duration(seconds: 2));
                  await CommunicationManager.conn.send(
                      "Connessione Riuscita!${CommunicationManager.peer.id}");

                  cancelLoading = BotToast.showLoading();
                  setState(() {});
                } else {
                  BotToast.showText(text: "Inserisci il codice di invito");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

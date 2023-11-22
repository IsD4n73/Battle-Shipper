import 'package:animated_emoji/animated_emoji.dart';
import 'package:battle_shipper/common/theme/app_color.dart';
import 'package:battle_shipper/common/utils/enums.dart';
import 'package:battle_shipper/common/utils/routes.dart';
import 'package:battle_shipper/presenter/view/placing/pages/ship_place.dart';
import 'package:battle_shipper/presenter/view/widget/battle_ship_button.dart';
import 'package:battle_shipper/presenter/view/widget/battle_ship_continue_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/mode_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool singlePlayer = true;
  String singleMode = "Easy";

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isPortrait = (orientation == Orientation.portrait);

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                "Welcome to Battleship".tr(),
                style: const TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ).tr(),
            )),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 10),
              child: Text(
                "Select a game mode".tr(),
                style: const TextStyle(color: Colors.grey),
              ),
            )),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: BattleShipButton(
                        selected: !singlePlayer,
                        text: "Multiplayer",
                        buttonType: BattleShipButtonType.light,
                        onPressed: () {
                          setState(() {
                            singlePlayer = false;
                          });
                          print("CIAO BROTHER");
                        },
                      ),
                    ),
                    Flexible(
                      child: BattleShipButton(
                          selected: singlePlayer,
                          text: "Singleplayer",
                          buttonType: BattleShipButtonType.dark,
                          onPressed: () {
                            setState(() {
                              singlePlayer = true;
                            });
                            print("HI SISTER");
                          }),
                    )
                  ],
                ),
              ),
            ),
            singlePlayer
                ? Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ModeButton(
                                selected: singleMode == "Easy",
                                emoji: AnimatedEmojis.smile,
                                text: "Easy".tr(),
                                onPressed: () {
                                  setState(() {
                                    singleMode = "Easy";
                                  });
                                }),
                            ModeButton(
                                selected: singleMode == "Normal",
                                emoji: AnimatedEmojis.neutralFace,
                                text: "Normal".tr(),
                                onPressed: () {
                                  setState(() {
                                    singleMode = "Normal";
                                  });
                                }),
                            ModeButton(
                                selected: singleMode == "Hard",
                                emoji: AnimatedEmojis.screaming,
                                text: "Hard".tr(),
                                onPressed: () {
                                  setState(() {
                                    singleMode = "Hard";
                                  });
                                }),
                            ModeButton(
                                selected: singleMode == "Battleshipper"
                                    ? true
                                    : false,
                                emoji: AnimatedEmojis.impSmile,
                                text: "Battleshipper",
                                onPressed: () {
                                  setState(() {
                                    singleMode = "Battleshipper";
                                  });
                                })
                          ],
                        )),
                  )
                : const SizedBox.shrink(),
            Center(
              heightFactor: isPortrait ? 5 : 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BattleShipContinueButton(
                    text: "JOIN",
                    buttonType: BattleShipButtonType.light,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DraggableShip(),
                          ));
                    },
                  ),
                  const SizedBox(height: 10),
                  !singlePlayer
                      ? BattleShipContinueButton(
                          text: "CREATE",
                          buttonType: BattleShipButtonType.dark,
                          onPressed: () {},
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

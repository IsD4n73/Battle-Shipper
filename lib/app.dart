import 'package:battle_shipper/common/theme/app_color.dart';
import 'package:battle_shipper/widget/battle_ship_button.dart';
import 'package:battle_shipper/widget/battle_ship_icon_button.dart';
import 'package:flutter/material.dart';

import 'common/utils/enums.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("TEST APP"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BattleShipButton(
                text: "Multiplayer",
                buttonType: BattleShipButtonType.light,
                onPressed: () {},
              ),
              BattleShipButton(
                text: "Singleplayer",
                buttonType: BattleShipButtonType.dark,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BattleShipIconButton(
                text: "Randomizer",
                buttonType: BattleShipButtonType.light,
                icon: Icons.chevron_right,
                onPressed: () {},
              ),
              BattleShipIconButton(
                text: "Randomizer",
                buttonType: BattleShipButtonType.dark,
                icon: Icons.chevron_right,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

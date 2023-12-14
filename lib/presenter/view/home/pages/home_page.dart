import 'package:battle_shipper/common/theme/app_color.dart';
import 'package:battle_shipper/common/utils/enums.dart';
import 'package:battle_shipper/common/utils/routes.dart';
import 'package:battle_shipper/presenter/view/widget/battle_ship_primary_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:username_gen/username_gen.dart';
import '../../../../common/utils/audio.dart';
import '../../../../common/utils/key_const.dart';
import '../widgets/multi_player_buttons.dart';
import '../widgets/single_player_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool singlePlayer = true;
  String singleMode = "Easy";
  final CarouselController carouselController = CarouselController();

  @override
  void initState() {
    Audio.playBackground();

    SharedPreferences.getInstance().then((prefs) {
      String? user = prefs.getString(KeyConst.sharedUsername);

      user ??= UsernameGen().generate();
      prefs.setString(KeyConst.sharedUsername, user);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

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
              ),
            )),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 10),
              child: Text(
                "Select a game mode".tr(),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            )),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: BattleShipPrimaryButton(
                          selected: singlePlayer,
                          text: "Singleplayer",
                          buttonType: BattleShipButtonType.dark,
                          onPressed: () {
                            carouselController.animateToPage(0);
                            setState(() {
                              singlePlayer = true;
                            });
                          }),
                    ),
                    Flexible(
                      child: BattleShipPrimaryButton(
                        selected: !singlePlayer,
                        text: "Multiplayer",
                        buttonType: BattleShipButtonType.light,
                        onPressed: () {
                          carouselController.animateToPage(1);
                          setState(() {
                            singlePlayer = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 1.0,
                height: MediaQuery.of(context).size.height / 2 + 50,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                onPageChanged: (index, reason) {
                  if (index == 0) {
                    singlePlayer = true;
                  } else {
                    singlePlayer = false;
                  }
                  setState(() {});
                },
                scrollDirection: Axis.horizontal,
              ),
              items: const [
                SinglePlayerButtons(),
                MultiPlayerButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

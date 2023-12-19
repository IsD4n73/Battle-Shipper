import 'package:battle_shipper/common/theme/app_color.dart';
import 'package:battle_shipper/common/utils/audio.dart';
import 'package:battle_shipper/common/utils/enums.dart';
import 'package:battle_shipper/common/utils/key_const.dart';
import 'package:battle_shipper/presenter/view/widget/battle_ship_secondary_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioSfxWidget extends StatefulWidget {
  const AudioSfxWidget({super.key});

  @override
  State<AudioSfxWidget> createState() => _AudioBgWidgetState();
}

class _AudioBgWidgetState extends State<AudioSfxWidget> {
  double currentVolume = 1;
  double currentVolumeSlider = 100;

  @override
  void initState() {
    Audio.getCurrentSFXVolume().then((value) {
      setState(() {
        currentVolumeSlider = value * 100;
        currentVolume = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Effects Volume").tr(),
          Slider(
            value: currentVolumeSlider,
            max: 100,
            min: 0,
            divisions: 100,
            label: currentVolumeSlider.round().toString(),
            activeColor: AppColor.secondaryColor,
            inactiveColor: AppColor.terziaryColor,
            onChangeEnd: (value) async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              setState(() {
                currentVolumeSlider = value;
                currentVolume = value / 100;
              });

              await prefs.setDouble(KeyConst.sharedSFX, currentVolume);
              await Audio.playerSfx.setVolume(currentVolume);
            },
            onChanged: (double value) async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              setState(() {
                currentVolumeSlider = value;
                currentVolume = value / 100;
              });

              await prefs.setDouble(KeyConst.sharedSFX, currentVolume);
              await Audio.playerSfx.setVolume(currentVolume);
            },
          ),
          BattleShipSecondaryButton(
            text: "Play",
            buttonType: BattleShipButtonType.light,
            onPressed: () async {
              await Audio.playExplosion();
            },
          ),
        ],
      ),
    );
  }
}

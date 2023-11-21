import 'package:battle_shipper/common/utils/audio.dart';
import 'package:battle_shipper/common/utils/key_const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioBgWidget extends StatefulWidget {
  const AudioBgWidget({super.key});

  @override
  State<AudioBgWidget> createState() => _AudioBgWidgetState();
}

class _AudioBgWidgetState extends State<AudioBgWidget> {
  double currentVolume = 1;
  double currentVolumeSlider = 100;

  @override
  void initState() {
    Audio.getCurrentBGVolume().then((value) {
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
          const Text("Volume Musica Sottofondo").tr(),
          Slider(
            value: currentVolumeSlider,
            max: 100,
            min: 0,
            divisions: 100,
            label: currentVolumeSlider.round().toString(),
            activeColor: Colors.red,
            inactiveColor: Colors.orange,
            onChangeEnd: (value) async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              setState(() {
                currentVolumeSlider = value;
                currentVolume = value / 100;
              });

              print("current volume value $currentVolume");

              await prefs.setDouble(KeyConst.sharedVolume, currentVolume);
              await Audio.playerBg.setVolume(currentVolume);
            },
            onChanged: (double value) async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              setState(() {
                currentVolumeSlider = value;
                currentVolume = value / 100;
              });

              print("current volume value $currentVolume");

              await prefs.setDouble(KeyConst.sharedVolume, currentVolume);
              await Audio.playerBg.setVolume(currentVolume);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:battle_shipper/common/utils/key_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Audio {
  static AudioPlayer playerBg = AudioPlayer();
  static AudioPlayer playerSfx = AudioPlayer();

  static Future<void> playBackground() async {
    playerBg.setReleaseMode(ReleaseMode.loop);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double volume = prefs.getDouble(KeyConst.sharedVolume) ?? 1;

    await playerBg.play(
      AssetSource("audio/bg.wav"),
      volume: volume,
    );
  }

  static Future<double> getCurrentBGVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(KeyConst.sharedVolume) ?? 1;
  }

  static Future<double> getCurrentSFXVolume() async {
    return 0.0;
  }
}

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

    if (volume == 0) {
      return;
    }

    await playerBg.play(
      AssetSource("audio/bg.wav"),
      volume: volume,
    );
  }
}

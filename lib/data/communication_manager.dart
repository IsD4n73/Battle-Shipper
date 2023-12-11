import 'dart:math';

import 'package:peerdart/peerdart.dart';

class CommunicationManager {
  static String suffixCode = "BS-";
  static Peer peer = Peer();

  static String getConnectionCode() {
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    return "$code";
  }
}
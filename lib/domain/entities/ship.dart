import 'package:flutter/cupertino.dart';

class Ship {
  int size;
  bool isDestroyed = false;
  bool isVertical = true;
  Image image;

  Ship({required this.size, required this.image});

  factory Ship.create(int size) {
    switch (size) {
      case 1:
        return Ship(
            size: size,
            image: Image.asset(
              "assets/images/ship_1.png",
              fit: BoxFit.contain,
              height: 120 + ((size - 1) * 60),
              width: 30,
            ));
      case 2:
        return Ship(
            size: size,
            image: Image.asset(
              "assets/images/ship_2.png",
              fit: BoxFit.contain,
              height: 120 + ((size - 1) * 60),
              width: 30,
            ));
      case 3:
        return Ship(
            size: size,
            image: Image.asset(
              "assets/images/ship_3.png",
              fit: BoxFit.contain,
              height: 120 + ((size - 1) * 60),
              width: 30,
            ));
      case 4:
        return Ship(
            size: size,
            image: Image.asset(
              "assets/images/ship_4.png",
              fit: BoxFit.contain,
              height: 120 + ((size - 1) * 60),
              width: 30,
            ));
      default:
        return Ship(
            size: 1,
            image: Image.asset(
              "assets/images/ship_1.png",
              fit: BoxFit.contain,
              height: 120 + (0 * 60),
              width: 30,
            ));
    }
  }
}

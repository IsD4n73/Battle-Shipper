import 'package:flutter/material.dart';

import '../../../common/theme/app_color.dart';
import '../../../common/utils/enums.dart';

class BattleShipContinueButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final BattleShipButtonType buttonType;

  const BattleShipContinueButton(
      {super.key,
      required this.text,
      this.onPressed,
      required this.buttonType});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonType == BattleShipButtonType.dark
            ? AppColor.primaryColor
            : AppColor.terziaryColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

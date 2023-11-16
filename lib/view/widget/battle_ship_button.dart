import 'package:flutter/material.dart';
import '../../common/theme/app_color.dart';
import '../../common/utils/enums.dart';

class BattleShipButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final BattleShipButtonType buttonType;

  const BattleShipButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.buttonType,
  });

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case BattleShipButtonType.light:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.whiteColor,
            foregroundColor: AppColor.blackColor,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: AppColor.blackColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      case BattleShipButtonType.dark:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            backgroundColor: AppColor.blackColor,
            foregroundColor: AppColor.whiteColor,
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: AppColor.whiteColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
    }
  }
}

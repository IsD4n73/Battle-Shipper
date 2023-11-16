import 'package:flutter/material.dart';
import '../common/theme/app_color.dart';
import '../common/utils/enums.dart';

class BattleShipIconButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final BattleShipButtonType buttonType;
  final IconData icon;

  const BattleShipIconButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.buttonType,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case BattleShipButtonType.light:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.whiteColor,
            foregroundColor: AppColor.blackColor,
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
          child: Row(
            children: [
              Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(icon),
            ],
          ),
        );
      case BattleShipButtonType.dark:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
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
          child: Row(
            children: [
              Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(icon),
            ],
          ),
        );
    }
  }
}

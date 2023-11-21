import 'package:flutter/material.dart';
import '../../../common/theme/app_color.dart';
import '../../../common/utils/enums.dart';

class BattleShipButton extends StatelessWidget {
  final bool selected;
  final String text;
  final void Function()? onPressed;
  final BattleShipButtonType buttonType;

  const BattleShipButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.buttonType,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonType == BattleShipButtonType.dark ? AppColor
            .primaryColor : AppColor.terziaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: selected ? AppColor
                .secondaryColor : Colors.transparent,
          ),
          borderRadius: const BorderRadius.all(
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

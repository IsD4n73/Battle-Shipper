import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../common/utils/enums.dart';
import '../../widget/battle_ship_secondary_button.dart';

class HeadArea extends StatelessWidget {
  final Function()? resetOnPressed;
  final Function()? continueOnPressed;
  final Function()? randomizeOnPressed;

  const HeadArea(
      {super.key,
      this.resetOnPressed,
      this.continueOnPressed,
      this.randomizeOnPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Click on ships to rotate them").tr(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BattleShipSecondaryButton(
              text: "Reset".tr(),
              buttonType: BattleShipButtonType.light,
              onPressed: resetOnPressed,
            ),
            BattleShipSecondaryButton(
              text: "Continue".tr(),
              buttonType: BattleShipButtonType.dark,
              onPressed: continueOnPressed,
            ),
            BattleShipSecondaryButton(
              text: "Randomize".tr(),
              buttonType: BattleShipButtonType.light,
              onPressed: randomizeOnPressed,
            ),
          ],
        ),
      ],
    );
  }
}

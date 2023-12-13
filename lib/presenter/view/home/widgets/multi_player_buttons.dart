import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../common/theme/app_color.dart';
import '../../../../common/utils/enums.dart';
import '../../widget/battle_ship_secondary_button.dart';
import '../pages/create_lobby.dart';
import '../pages/join_lobby.dart';

class MultiPlayerButtons extends StatelessWidget {
  const MultiPlayerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: [AppColor.terziaryColor, AppColor.primaryColor],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.srcIn,
            child: Image.asset(
              "assets/images/bs_multi.png",
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 1200.ms, color: AppColor.terziaryColor)
              .animate(),
        ),
        BattleShipSecondaryButton(
          text: "JOIN".tr(),
          buttonType: BattleShipButtonType.light,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JoinLobby(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        BattleShipSecondaryButton(
          text: "CREATE".tr(),
          buttonType: BattleShipButtonType.dark,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateLobby(),
                ));
          },
        ),
      ],
    );
  }
}

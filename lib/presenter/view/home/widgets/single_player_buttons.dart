import 'package:animated_emoji/emojis.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../common/theme/app_color.dart';
import '../../../../common/utils/enums.dart';
import '../../placing/pages/placing_page.dart';
import '../../widget/battle_ship_secondary_button.dart';
import '../pages/home_page.dart';
import 'mode_button.dart';

class SinglePlayerButtons extends StatefulWidget {
  const SinglePlayerButtons({super.key});

  @override
  State<SinglePlayerButtons> createState() => _SinglePlayerButtonsState();
}

class _SinglePlayerButtonsState extends State<SinglePlayerButtons> {
  late HomePageState ancestralState;
  @override
  void initState() {
    ancestralState = context.findAncestorStateOfType<HomePageState>()!;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ModeButton(
                selected: ancestralState.singleMode == "Easy",
                emoji: AnimatedEmojis.smile,
                text: "Easy".tr(),
                onPressed: () {
                  ancestralState.setState(() {
                    ancestralState.singleMode = "Easy";
                  });
                },
              ),
              ModeButton(
                  selected: ancestralState.singleMode == "Normal",
                  emoji: AnimatedEmojis.neutralFace,
                  text: "Normal".tr(),
                  onPressed: () {
                    ancestralState.setState(() {
                      ancestralState.singleMode = "Normal";
                    });
                  }),
              ModeButton(
                  selected: ancestralState.singleMode == "Hard",
                  emoji: AnimatedEmojis.screaming,
                  text: "Hard".tr(),
                  onPressed: () {
                    ancestralState.setState(() {
                      ancestralState.singleMode = "Hard";
                    });
                  }),
              ModeButton(
                  selected: ancestralState.singleMode == "Battleshipper"
                      ? true
                      : false,
                  emoji: AnimatedEmojis.impSmile,
                  text: "Battleshipper",
                  onPressed: () {
                    ancestralState.setState(() {
                      ancestralState.singleMode = "Battleshipper";
                    });
                  })
            ],
          ),
        ),
        const SizedBox(height: 20),
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [AppColor.terziaryColor, AppColor.primaryColor],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.srcIn,
          child: Image.asset(
            "assets/images/bs_single.png",
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1200.ms, color: AppColor.terziaryColor)
            .animate(),
        const SizedBox(height: 20),
        BattleShipSecondaryButton(
          text: "JOIN".tr(),
          buttonType: BattleShipButtonType.light,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlacingPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

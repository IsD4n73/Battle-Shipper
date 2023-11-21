import 'package:animated_emoji/animated_emoji.dart';
import 'package:battle_shipper/common/theme/app_color.dart';
import 'package:flutter/material.dart';

class ModeButton extends StatelessWidget {
  final String text;
  final bool selected;
  final AnimatedEmojiData emoji;
  final Function()? onPressed;

  const ModeButton(
      {super.key, required this.text, required this.emoji, this.onPressed, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.5,
              color: selected ? AppColor.secondaryColor : Colors.transparent,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                backgroundColor: AppColor.primaryColor[100],
                child: AnimatedEmoji(
                  emoji,
                )),
            const SizedBox(width: 5),
            Text(text),
          ],
        ),
      ),
    );
  }
}

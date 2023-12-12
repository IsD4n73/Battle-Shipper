import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/theme/app_color.dart';
import '../../../../common/utils/enums.dart';
import '../../widget/battle_ship_secondary_button.dart';

class UsernameWidget extends StatefulWidget {
  const UsernameWidget({super.key});

  @override
  State<UsernameWidget> createState() => _UsernameWidgetState();
}

class _UsernameWidgetState extends State<UsernameWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      String? user = prefs.getString('BS-username');

      _controller.text = user ?? "";
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              cursorColor: AppColor.terziaryColor,
              controller: _controller,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                label: Text(
                  "Username",
                  style: TextStyle(
                    color: AppColor.primaryColor,
                  ),
                ),
              )),
          BattleShipSecondaryButton(
            text: "Save",
            buttonType: BattleShipButtonType.dark,
            onPressed: () async {
              if (_controller.text.isNotEmpty) {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("BS-username", _controller.text);
                BotToast.showText(text: "Username salvato");
              }
            },
          )
        ],
      ),
    );
  }
}

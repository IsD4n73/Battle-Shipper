import 'package:bot_toast/bot_toast.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  List<DropdownMenuItem<Object>> dropdownLocale = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        dropdownLocale = List.generate(
          context.supportedLocales.length,
          (index) => DropdownMenuItem<String>(
            value: context.supportedLocales[index].languageCode,
            child: Row(
              children: [
                Text(
                  context.supportedLocales[index].languageCode.toUpperCase(),
                ),
                const SizedBox(width: 8),
                LanguageFlag(
                  language: Language.fromCode(
                      context.supportedLocales[index].languageCode),
                  height: 20,
                ),
              ],
            ),
          ),
        );
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Language:".tr()),
          DropdownButton(
            items: dropdownLocale,
            value: context.locale.languageCode,
            onChanged: (value) {
              BotToast.showText(
                text: kIsWeb
                    ? "Change Language Warning Web".tr()
                    : "Change Language Warning".tr(),
              );
              setState(() {
                context.setLocale(Locale(value.toString()));
              });
            },
          ),
        ],
      ),
    );
  }
}

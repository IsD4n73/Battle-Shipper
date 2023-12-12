import 'package:battle_shipper/presenter/view/settings/widget/audiobg_widget.dart';
import 'package:battle_shipper/presenter/view/settings/widget/audiosfx_widget.dart';
import 'package:battle_shipper/presenter/view/settings/widget/language_widget.dart';
import 'package:battle_shipper/presenter/view/settings/widget/username_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Settings".tr()),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            LanguageWidget(),
            UsernameWidget(),
            AudioBgWidget(),
            AudioSfxWidget(),
          ],
        ),
      ),
    );
  }
}

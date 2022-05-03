import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/modules/auth/repos/auth_repo.dart';
import 'package:chart_ganga/modules/main/screens/main_screen_wrapper.dart';
import 'package:chart_ganga/modules/settings/widgets/setting_tile_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../configs/app_routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Column(
        children: [
          SettingTileScreen(
              icon: EvaIcons.bell,
              text: "Notifications",
              onTap: () {
                Navigator.pushNamed(context, NOTIFICATION_ROUTE);
              }),
          SettingTileScreen(
              icon: EvaIcons.edit,
              text: "Edit Profile",
              onTap: () {
                Navigator.pushNamed(context, PROFILE_EDIT_SCREEN);
              }),
          SettingTileScreen(icon: EvaIcons.star, text: "Rate Us", onTap: () {}),
          SettingTileScreen(
              icon: EvaIcons.shield,
              text: "Privacy Policy",
              onTap: () {
                Navigator.pushNamed(context, PRIVACY_POLICY);
              }),
          SettingTileScreen(
              icon: EvaIcons.file,
              text: "Terms and Conditions",
              onTap: () {
                Navigator.pushNamed(context, TERMS_AND_CONDITIONS);
              }),
          SettingTileScreen(
              icon: EvaIcons.questionMarkCircle,
              text: "About Us",
              onTap: () {
                Navigator.pushNamed(context, ABOUT_SCREEN);
              }),
          SettingTileScreen(
              icon: EvaIcons.logOut,
              isLogOut: true,
              text: "Log Out",
              onTap: () {
                AuthRepo().logout(context);
              }),
        ],
      ),
    );
  }
}

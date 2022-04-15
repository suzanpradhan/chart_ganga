import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class SettingTileScreen extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;
  final bool? isLogOut;
  const SettingTileScreen(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onTap,
      this.isLogOut = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          child: Row(
            children: [
              Icon(
                icon,
                color:
                    (isLogOut!) ? Colors.redAccent : CustomColors.purpleRegular,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  text,
                  style: (!isLogOut!)
                      ? Theme.of(context).textTheme.bodyText1
                      : TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 14,
                          color: Colors.redAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

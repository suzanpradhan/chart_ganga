import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class NotiftileWidget extends StatelessWidget {
  final String text;
  final String label;
  const NotiftileWidget({Key? key, required this.text, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: CustomColors.purpleLight,
                borderRadius: BorderRadius.circular(99)),
            child: Icon(
              EvaIcons.checkmark,
              size: 24,
              color: CustomColors.purpleRegular,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  label,
                  style: TextStyle(
                      color: CustomColors.greyRegular,
                      fontSize: 12,
                      fontFamily: "PoppinsRegular"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function() onTap;
  final bool? isLoading;

  const CustomButton({Key? key, this.text, required this.onTap, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: CustomColors.purpleRegular,
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: (isLoading != null && isLoading!)
              ? CircularProgressIndicator(
                  strokeWidth: 1,
                  color: CustomColors.purpleLight,
                )
              : Text(
                  (text != null) ? text! : "",
                  style: Theme.of(context).textTheme.button,
                ),
        ),
      ),
    );
  }
}

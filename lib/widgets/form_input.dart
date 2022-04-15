import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String? title;
  final String? placeholder;
  final bool obsecureText;
  final TextEditingController? controller;
  final String? errorMessage;
  final Function(String)? onChanged;
  const FormInput(
      {Key? key,
      this.title,
      this.placeholder,
      this.obsecureText = false,
      this.errorMessage,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (title != null)
              ? Text(
                  title!,
                  style: Theme.of(context).textTheme.headline3,
                )
              : SizedBox(),
          TextField(
            controller: controller,
            obscureText: obsecureText,
            onChanged: onChanged,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.purpleShadeLight,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.purpleRegular,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: CustomColors.purpleShadeLight,
                    width: 1,
                  ),
                ),
                fillColor: CustomColors.purpleLight,
                filled: true,
                hintText: placeholder,
                hintStyle: Theme.of(context).textTheme.bodyText2,
                isDense: true),
            cursorColor: CustomColors.black,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          (errorMessage != null)
              ? Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: CustomColors.red.withOpacity(0.2),
                        border:
                            Border.all(width: 0.5, color: CustomColors.red)),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(
                          fontFamily: "FFMarkRegular",
                          fontSize: 12,
                          color: CustomColors.red),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

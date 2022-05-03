import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class PaymentCompleted extends StatelessWidget {
  const PaymentCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          "Completed",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/payment_completed_graphic.png",
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Your withdrawl is in progress. It might take upto 2-3 business days.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 14,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, HOMEPAGE_ROUTE);
              },
              child: Container(
                width: 100,
                constraints: BoxConstraints(minWidth: 0),
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: CustomColors.purpleRegular,
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: Text(
                    "OKAY",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/widgets/custom_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          "Withdraw",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 14,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14),
                height: 60,
                decoration: BoxDecoration(
                    color: CustomColors.purpleLight,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Points",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      "100.34",
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Select payment methods",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: CustomColors.purpleShadeLight, width: 1),
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.purpleLight),
                child: Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/paytm_icon.png"))),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Paytm",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: CustomColors.purpleShadeLight, width: 1),
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.purpleLight),
                child: Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/paypal_icon.png"))),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Paypal",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: CustomColors.purpleShadeLight, width: 1),
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.purpleLight),
                child: Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/R.jfif"))),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "UPI id",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 1,
                      height: 80,
                      decoration: BoxDecoration(color: CustomColors.greyDark),
                    ),
                  ],
                ),
              ),
              Text(
                "Enter an amount to withdraw",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: CustomColors.purpleShadeLight, width: 1),
                    color: CustomColors.purpleLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Center(
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: "Amount",
                            hintStyle: Theme.of(context).textTheme.bodyText2),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              CustomButton(
                text: "WITHDRAW NOW",
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, PAYMENT_COMPLETED_ROUTE);
                },
              ),
              SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

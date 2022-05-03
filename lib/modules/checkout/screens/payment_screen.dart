import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/modules/checkout/blocs/withdraw_bloc/withdraw_bloc.dart';
import 'package:chart_ganga/widgets/custom_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile/blocs/getMyWalletBloc/getmywallet_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late bool isPaytmPlatform;

  late TextEditingController _amountController;
  late TextEditingController _idController;

  @override
  void initState() {
    isPaytmPlatform = true;
    _amountController = TextEditingController();
    _idController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return GetmywalletBloc()..add(GetMyWalletAttemptEvent());
        }),
        BlocProvider(create: (context) {
          return WithdrawBloc();
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: CustomColors.black),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          title: Text(
            "Withdraw",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: BlocBuilder<GetmywalletBloc, GetmywalletState>(
          builder: (context, state) {
            return SingleChildScrollView(
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
                            (state is GetMyWalletSuccessState)
                                ? state.wallet.amount.toString() + " points"
                                : "--",
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          isPaytmPlatform = true;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: isPaytmPlatform
                                    ? CustomColors.purpleRegular
                                    : CustomColors.purpleShadeLight,
                                width: 1),
                            borderRadius: BorderRadius.circular(5),
                            color: isPaytmPlatform
                                ? CustomColors.purpleShadeLight
                                : CustomColors.purpleLight),
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
                                      image: AssetImage(
                                          "assets/images/paytm_icon.png"))),
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
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isPaytmPlatform = false;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: !isPaytmPlatform
                                    ? CustomColors.purpleRegular
                                    : CustomColors.purpleShadeLight,
                                width: 1),
                            borderRadius: BorderRadius.circular(5),
                            color: !isPaytmPlatform
                                ? CustomColors.purpleShadeLight
                                : CustomColors.purpleLight),
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
                                          AssetImage("assets/images/R.jfif"))),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 1,
                            height: 80,
                            decoration:
                                BoxDecoration(color: CustomColors.greyDark),
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
                              controller: _amountController,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  hintText: "Amount",
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      isPaytmPlatform ? "Paytm ID" : "UPI ID",
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
                              controller: _idController,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  hintText:
                                      isPaytmPlatform ? "Paytm ID" : "UPI ID",
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    BlocConsumer<WithdrawBloc, WithdrawState>(
                      listener: (context, state) {
                        if (state is WithdrawSuccessState) {
                          Navigator.pushReplacementNamed(
                              context, PAYMENT_COMPLETED_ROUTE);
                        } else if (state is WithdrawFailedState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            state.message,
                            style: TextStyle(color: CustomColors.red),
                          )));
                        }
                      },
                      builder: (context, withdrawState) {
                        return CustomButton(
                          text: "WITHDRAW NOW",
                          isLoading: (withdrawState is WithdrawLoadingState),
                          onTap: () {
                            if (state is GetMyWalletSuccessState) {
                              if (_amountController.text.isNotEmpty &&
                                  state.wallet.amount >=
                                      double.parse(_amountController.text)) {
                                if (_idController.text.isNotEmpty) {
                                  context.read<WithdrawBloc>()
                                    ..add(WithdrawAttempt(
                                        amount: _amountController.text,
                                        id: _idController.text,
                                        isPaytm: isPaytmPlatform));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Enter your " +
                                        (isPaytmPlatform
                                            ? "Paytm ID"
                                            : "UPI ID"),
                                    style: TextStyle(color: CustomColors.red),
                                  )));
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  "Insufficient Amount.",
                                  style: TextStyle(color: CustomColors.red),
                                )));
                              }
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

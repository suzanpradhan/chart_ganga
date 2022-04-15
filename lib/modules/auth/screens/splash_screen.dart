import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/modules/auth/blocs/authChecker/authcheck_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthcheckBloc()..add(AuthCheckaAttempt()),
      child: BlocListener<AuthcheckBloc, AuthcheckState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushNamed(context, HOMEPAGE_ROUTE);
          } else {
            Navigator.pushNamed(context, LOGIN_ROUTE);
          }
        },
        child: Scaffold(
          backgroundColor: CustomColors.purpleRegular,
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chart Ganga",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: CustomColors.white),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  width: 50,
                  child: LinearProgressIndicator(
                    minHeight: 2,
                    color: CustomColors.purpleRegular,
                    backgroundColor: CustomColors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

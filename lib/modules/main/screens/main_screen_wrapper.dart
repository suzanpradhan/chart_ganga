import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class MainScreenWrapper extends StatelessWidget {
  final Widget child;
  final String route;
  final PreferredSizeWidget? appBar;
  const MainScreenWrapper(
      {Key? key, required this.child, this.appBar, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: child,
      bottomNavigationBar: Container(
        height: 50,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: CustomColors.purpleLight,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (route != HOMEPAGE_ROUTE) {
                          Navigator.pushReplacementNamed(
                              context, HOMEPAGE_ROUTE);
                        }
                      },
                      icon: Icon(EvaIcons.home,
                          color: (route == HOMEPAGE_ROUTE)
                              ? CustomColors.purpleRegular
                              : CustomColors.greyRegular)),
                  IconButton(
                      onPressed: () {
                        if (route != SEARCH_ROUTE) {
                          Navigator.pushNamed(context, SEARCH_ROUTE);
                        }
                      },
                      icon: Icon(EvaIcons.search,
                          color: (route == SEARCH_ROUTE)
                              ? CustomColors.purpleRegular
                              : CustomColors.greyRegular)),
                  IconButton(
                      onPressed: () {
                        if (route != ADDNEWPOST_ROUTE) {
                          Navigator.pushNamed(context, ADDNEWPOST_ROUTE);
                        }
                      },
                      icon: Icon(EvaIcons.plus,
                          color: (route == ADDNEWPOST_ROUTE)
                              ? CustomColors.purpleRegular
                              : CustomColors.greyRegular)),
                  IconButton(
                      onPressed: () {
                        if (route != NOTIFICATION_ROUTE) {
                          Navigator.pushReplacementNamed(
                              context, NOTIFICATION_ROUTE);
                        }
                      },
                      icon: Icon(EvaIcons.bell,
                          color: (route == NOTIFICATION_ROUTE)
                              ? CustomColors.purpleRegular
                              : CustomColors.greyRegular)),
                  InkWell(
                    onTap: () {
                      if (route != PROFILE_ROUTE) {
                        Navigator.pushReplacementNamed(context, PROFILE_ROUTE);
                      }
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/profile_image.png"))),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

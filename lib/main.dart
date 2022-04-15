import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/configs/custom_theme.dart';
import 'package:chart_ganga/modules/auth/screens/login_screen.dart';
import 'package:chart_ganga/modules/auth/screens/register_screen.dart';
import 'package:chart_ganga/modules/auth/screens/splash_screen.dart';
import 'package:chart_ganga/modules/checkout/screens/payment_screen.dart';
import 'package:chart_ganga/modules/home/screens/homepage.dart';
import 'package:chart_ganga/modules/checkout/screens/payment_completed.dart';
import 'package:chart_ganga/modules/new_post/screens/add_new_post.dart';
import 'package:chart_ganga/modules/notifications/screens/notification_screen.dart';
import 'package:chart_ganga/modules/posts/screens/post_detail_screen.dart';
import 'package:chart_ganga/modules/profile/screens/profile_screen.dart';
import 'package:chart_ganga/modules/search/screens/search_screen.dart';
import 'package:chart_ganga/modules/settings/screens/setting_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Ganga',
      theme: CustomTheme.lightTheme,
      initialRoute: SPLASH_ROUTE,
      routes: {
        SPLASH_ROUTE: (context) => SplashScreen(),
        HOMEPAGE_ROUTE: (context) => HomePage(),
        SEARCH_ROUTE: (context) => SearchScreen(),
        ADDNEWPOST_ROUTE: (context) => AddNewPost(),
        NOTIFICATION_ROUTE: (context) => NotificationScreen(),
        PROFILE_ROUTE: (context) => ProfileScreen(),
        SETTINGS_ROUTE: (context) => SettingsScreen(),
        PAYMENT_ROUTE: (context) => PaymentScreen(),
        PAYMENT_COMPLETED_ROUTE: (context) => PaymentCompleted(),
        LOGIN_ROUTE: (context) => LoginScreen(),
        REGISTER_ROUTE: (context) => RegisterScreen()
      },
    );
  }
}

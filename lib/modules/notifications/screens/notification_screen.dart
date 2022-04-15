import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/modules/main/screens/main_screen_wrapper.dart';
import 'package:chart_ganga/modules/notifications/blocs/getMyNotificationsBloc/getmynotifications_bloc.dart';
import 'package:chart_ganga/modules/notifications/widgets/notif_tile_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetmynotificationsBloc()..add(GetMyNotificationsAttemptEvent()),
      child: MainScreenWrapper(
        route: NOTIFICATION_ROUTE,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          title: Text(
            "Notifications",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        child: BlocConsumer<GetmynotificationsBloc, GetmynotificationsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is GetMyNotificationsSuccessState) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  physics: BouncingScrollPhysics(),
                  itemCount: state.listOfNotifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NotiftileWidget(
                      text: state.listOfNotifications[index].content ?? "--",
                      label: state.listOfNotifications[index].createdAt ?? "--",
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: CustomColors.purpleRegular,
                  strokeWidth: 1,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

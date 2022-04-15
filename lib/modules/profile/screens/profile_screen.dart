import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/modules/home/widgets/feed_card.dart';
import 'package:chart_ganga/modules/home/widgets/shimmer_feed_card.dart';
import 'package:chart_ganga/modules/main/screens/main_screen_wrapper.dart';
import 'package:chart_ganga/modules/profile/blocs/getMyWalletBloc/getmywallet_bloc.dart';
import 'package:chart_ganga/modules/profile/blocs/getProfilePostsBloc/getprofileposts_bloc.dart';
import 'package:chart_ganga/modules/profile/blocs/getUserBloc/getuser_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = PROFILE_ROUTE;
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isMyposts = true;

  @override
  Widget build(BuildContext context) {
    return MainScreenWrapper(
      route: PROFILE_ROUTE,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "My profile",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            return GetprofilepostsBloc()..add(GetMyPostsAttemptEvent());
          }),
          BlocProvider(create: (context) {
            return GetmywalletBloc()..add(GetMyWalletAttemptEvent());
          }),
          BlocProvider(create: (context) {
            return GetuserBloc()..add(GetUserAttemptEvent());
          }),
        ],
        child: BlocConsumer<GetprofilepostsBloc, GetprofilepostsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: (state is GetProfilePostsLoadingState)
                  ? NeverScrollableScrollPhysics()
                  : BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColors.purpleLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // height: 100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/profile_image.png"))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                BlocBuilder<GetmywalletBloc, GetmywalletState>(
                                  builder: (context, state) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BlocBuilder<GetuserBloc, GetuserState>(
                                          builder: (context, state) {
                                            return Text(
                                              (state is GetUserSuccessState)
                                                  ? state.user.username!
                                                  : "--",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            );
                                          },
                                        ),
                                        Text(
                                          (state is GetMyWalletSuccessState)
                                              ? (state as GetMyWalletSuccessState)
                                                      .wallet
                                                      .amount
                                                      .toString() +
                                                  " points"
                                              : "--",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, PAYMENT_ROUTE);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color:
                                                    CustomColors.purpleRegular,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Withdraw",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "PoppinsRegular",
                                                      color: CustomColors.white,
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  EvaIcons.download,
                                                  size: 18,
                                                  color: CustomColors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, SETTINGS_ROUTE);
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: CustomColors.white),
                                child: Icon(
                                  EvaIcons.settings,
                                  size: 20,
                                  color: CustomColors.purpleRegular,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: CustomColors.purpleLight,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (isMyposts != true) {
                                  setState(() {
                                    isMyposts = true;
                                  });
                                  context
                                      .read<GetprofilepostsBloc>()
                                      .add(GetMyPostsAttemptEvent());
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: (isMyposts)
                                        ? CustomColors.purpleRegular
                                        : CustomColors.purpleLight,
                                    borderRadius: BorderRadius.circular(6)),
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Center(
                                  child: Text(
                                    "MY POSTS",
                                    style: (isMyposts)
                                        ? Theme.of(context).textTheme.button
                                        : Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (isMyposts != false) {
                                  setState(() {
                                    isMyposts = false;
                                  });
                                  context
                                      .read<GetprofilepostsBloc>()
                                      .add(GetSavedPostsAttemptEvent());
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: (!isMyposts)
                                        ? CustomColors.purpleRegular
                                        : CustomColors.purpleLight,
                                    borderRadius: BorderRadius.circular(6)),
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Center(
                                  child: Text(
                                    "SAVED",
                                    style: (!isMyposts)
                                        ? Theme.of(context).textTheme.button
                                        : Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (state is GetProfilePostsSuccessState)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 14),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.listOfPosts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: FeedCard(
                                postModel: state.listOfPosts[index],
                              ),
                            );
                          }),
                    )
                  else if (state is GetMySavedPostsSuccessState)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 14),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.listOfSavedPosts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: FeedCard(
                                postModel: state.listOfSavedPosts[index].post!,
                              ),
                            );
                          }),
                    )
                  else
                    Column(
                      children: [
                        SizedBox(
                          height: 14,
                        ),
                        ShimmerFeedCard(),
                        SizedBox(
                          height: 14,
                        ),
                        ShimmerFeedCard(),
                      ],
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

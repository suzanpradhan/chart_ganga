import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/modules/home/blocs/categoryBloc/category_bloc.dart';
import 'package:chart_ganga/modules/home/widgets/feed_card.dart';
import 'package:chart_ganga/modules/home/widgets/shimmer_feed_card.dart';
import 'package:chart_ganga/modules/main/screens/main_screen_wrapper.dart';
import 'package:chart_ganga/modules/posts/blocs/getfeedpostbloc/getfeedpost_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CategoryBloc()..add(GetAllCategoryEvent())),
        BlocProvider(
          create: (context) => GetfeedpostBloc(),
        ),
      ],
      child: MainScreenWrapper(
        route: HOMEPAGE_ROUTE,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          toolbarHeight: 50,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Chart Ganga",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            width: 180,
                            decoration: BoxDecoration(
                              color: CustomColors.purpleLight,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(
                                    EvaIcons.search,
                                    color: CustomColors.black,
                                    size: 24,
                                  ),
                                ),
                                Expanded(
                                    child: TextField(
                                  onTap: () {
                                    Navigator.pushNamed(context, SEARCH_ROUTE);
                                  },
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      hintText: "Search",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: CustomColors.purpleLight,
                  )
                ],
              ),
            ),
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<GetfeedpostBloc, GetfeedpostState>(
            builder: (context, state) {
              return SingleChildScrollView(
                physics: (state is GetFeedPostLoadingState)
                    ? NeverScrollableScrollPhysics()
                    : BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    BlocListener<CategoryBloc, CategoryState>(
                      listener: (context, state) {
                        if (state is GetAllCategorySuccessState) {
                          if (currentIndex == 0) {
                            context
                                .read<GetfeedpostBloc>()
                                .add(GetTrendingPostsEvent());
                          }
                        }
                      },
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          if (state is GetAllCategorySuccessState) {
                            return Container(
                              height: 40,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(20, 0, 8, 0),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.categoryList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (currentIndex == 0) {
                                        context
                                            .read<GetfeedpostBloc>()
                                            .add(GetTrendingPostsEvent());
                                      } else {
                                        context.read<GetfeedpostBloc>().add(
                                            GetPostsByCategoryEvent(
                                                categoryModel:
                                                    state.categoryList[index]));
                                      }
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      margin: EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(99),
                                          color: (currentIndex == index)
                                              ? CustomColors.purpleRegular
                                              : CustomColors.purpleLight,
                                          border: Border.all(
                                              color: CustomColors.purpleRegular,
                                              width: 1)),
                                      child: Center(
                                        child: Text(
                                          state.categoryList[index].name ?? "",
                                          style: (currentIndex == index)
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .button
                                              : Theme.of(context)
                                                  .textTheme
                                                  .button!
                                                  .copyWith(
                                                      color: CustomColors
                                                          .purpleShadeLight),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                    if (state is GotFeedPostSuccessState)
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
      ),
    );
  }
}

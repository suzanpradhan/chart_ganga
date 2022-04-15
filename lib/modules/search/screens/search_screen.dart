import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/modules/home/widgets/feed_card.dart';
import 'package:chart_ganga/modules/home/widgets/shimmer_feed_card.dart';
import 'package:chart_ganga/modules/main/screens/main_screen_wrapper.dart';
import 'package:chart_ganga/modules/search/blocs/searchPostsBloc/searchposts_bloc.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  static const String route = SEARCH_ROUTE;
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchpostsBloc(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<SearchpostsBloc, SearchpostsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 0, 5),
                            child: Container(
                              width: 180,
                              decoration: BoxDecoration(
                                color: CustomColors.purpleLight,
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Icon(
                                      EvaIcons.search,
                                      color: CustomColors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Expanded(
                                      child: TextField(
                                    autofocus: true,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    onChanged: (String value) {
                                      context.read<SearchpostsBloc>().add(
                                          SearchPostsAttemptEvent(
                                              value: value));
                                    },
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
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            EvaIcons.close,
                            color: CustomColors.black,
                          ))
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: CustomColors.purpleLight,
                  ),
                  if (state is SearchPostsSuccessState)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                            padding: EdgeInsets.only(top: 14),
                            physics: BouncingScrollPhysics(),
                            itemCount: state.listOfPosts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: FeedCard(
                                  postModel: state.listOfPosts[index],
                                ),
                              );
                            }),
                      ),
                    )
                  else if (state is SearchPostsLoadingState)
                    Expanded(
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
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
                        ),
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

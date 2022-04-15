import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/api_paths.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/modules/home/blocs/postVoteBloc/postvote_bloc.dart';
import 'package:chart_ganga/modules/posts/blocs/bookmarkBloc/bookmark_bloc.dart';
import 'package:chart_ganga/modules/posts/models/post_model.dart';
import 'package:chart_ganga/modules/posts/screens/post_detail_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:share_plus/share_plus.dart';

class FeedCard extends StatefulWidget {
  final PostModel postModel;
  const FeedCard({Key? key, required this.postModel}) : super(key: key);

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  late PostModel postModel;
  double count = 0.6;
  late bool isBookmarked;

  @override
  void initState() {
    postModel = widget.postModel;
    isBookmarked = widget.postModel.isBookmarked ?? false;
    super.initState();
    calculateVotes();
  }

  bool isClicked = false;
  int totalVotes = 0;

  calculateVotes() {
    totalVotes = (postModel.upVotes ?? 0) +
        (postModel.downVotes ?? 0) +
        (postModel.sideVotes ?? 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostvoteBloc(),
        ),
        BlocProvider(
          create: (context) => BookmarkBloc(),
        ),
      ],
      child: BlocConsumer<PostvoteBloc, PostvoteState>(
        listener: (context, state) {
          if (state is PostVoteSuccessState) {
            setState(() {
              postModel = state.postModel;
              calculateVotes();
            });
          }
        },
        builder: (context, state) {
          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return PostDetailScreen(postModel: postModel);
                  }));
                },
                child: Container(
                  height: 280,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              ApiPaths.baseUrl + postModel.coverImageLink!))),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postModel.title ?? "--",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        postModel.createdAt.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Share.share('Test Share');
                        },
                        child: Icon(
                          EvaIcons.shareOutline,
                          color: CustomColors.greyDark,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      BlocConsumer<BookmarkBloc, BookmarkState>(
                        listener: (context, state) {
                          if (state is AddToBookmarkSuccessState) {
                            setState(() {
                              isBookmarked = state.isBookmarked;
                            });
                          }
                        },
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              context.read<BookmarkBloc>().add(
                                  AddToBookmarkAttemptEvent(
                                      postId: postModel.id!));
                            },
                            child: Icon(
                              isBookmarked
                                  ? EvaIcons.bookmark
                                  : EvaIcons.bookmarkOutline,
                              color: CustomColors.greyDark,
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                postModel.content ?? "",
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  OptionWidget(
                    onTap: () {
                      context.read<PostvoteBloc>().add(
                          AddVoteAttemptEvent(vote: 1, postId: postModel.id!));
                    },
                    isVoted: postModel.isVoted ?? false,
                    color: Colors.greenAccent,
                    topValue: (totalVotes != 0)
                        ? (postModel.upVotes! / totalVotes)
                        : 0,
                    type: "Up",
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  OptionWidget(
                    onTap: () {
                      context.read<PostvoteBloc>().add(
                          AddVoteAttemptEvent(vote: 2, postId: postModel.id!));
                    },
                    isVoted: postModel.isVoted ?? false,
                    color: Colors.orangeAccent,
                    topValue: (totalVotes != 0)
                        ? (postModel.downVotes! / totalVotes)
                        : 0,
                    type: "Down",
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  OptionWidget(
                    onTap: () {
                      context.read<PostvoteBloc>().add(
                          AddVoteAttemptEvent(vote: 3, postId: postModel.id!));
                    },
                    isVoted: postModel.isVoted ?? false,
                    color: Colors.blueAccent,
                    topValue: (totalVotes != 0)
                        ? (postModel.sideVotes! / totalVotes)
                        : 0,
                    type: "Side",
                  ),
                ],
              )
            ],
          ));
        },
      ),
    );
  }
}

class OptionWidget extends StatefulWidget {
  final double topValue;
  final String type;
  final bool isVoted;
  final Color color;
  final Function() onTap;
  const OptionWidget(
      {Key? key,
      required this.topValue,
      required this.onTap,
      required this.type,
      required this.isVoted,
      required this.color})
      : super(key: key);
  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocListener<PostvoteBloc, PostvoteState>(
        listener: (context, state) {},
        child: (widget.isVoted)
            ? InkWell(
                onTap: widget.onTap,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GFProgressBar(
                            percentage: widget.topValue,
                            lineHeight: 40,
                            animation: true,
                            radius: 50,
                            backgroundColor: widget.color.withOpacity(0.2),
                            progressBarColor: widget.color),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${(widget.topValue * 100).toInt()}% ${widget.type.toUpperCase()}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : InkWell(
                onTap: widget.onTap,
                splashColor: widget.color,
                borderRadius: BorderRadius.circular(99),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: widget.color, width: 1)),
                  child: Center(
                    child: Text(
                      widget.type.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

import 'package:chart_ganga/constants/api_paths.dart';
import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:chart_ganga/modules/main/screens/main_screen_wrapper.dart';
import 'package:chart_ganga/modules/posts/models/post_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel postModel;
  const PostDetailScreen({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          "Detail",
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
              Image.network(
                ApiPaths.baseUrl + postModel.coverImageLink!,
                fit: BoxFit.contain,
              ),
              // Container(
              //   // constraints: BoxConstraints(maxHeight: 320),
              //   // height: 280,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       image: DecorationImage(
              //           fit: BoxFit.contain,
              //           image: NetworkImage(
              //               ApiPaths.baseUrl + postModel.coverImageLink!))),
              // ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/image1.jpeg"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ALEX BROOKER",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "29 Oct",
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        EvaIcons.shareOutline,
                        color: CustomColors.greyDark,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        EvaIcons.bookmarkOutline,
                        color: CustomColors.greyDark,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                postModel.title ?? "--",
                style: Theme.of(context).textTheme.headline2,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                postModel.content ?? "",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          color: CustomColors.purpleLight,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: CustomColors.purpleShadeLight, width: 1)),
                      child: Center(
                        child: Text(
                          "UP",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: CustomColors.purpleLight,
                          border: Border.all(
                              color: CustomColors.purpleShadeLight, width: 1)),
                      child: Center(
                        child: Text(
                          "DOWN",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: CustomColors.purpleLight,
                          border: Border.all(
                              color: CustomColors.purpleShadeLight, width: 1)),
                      child: Center(
                        child: Text(
                          "SIDEWAYS",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  )
                ],
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

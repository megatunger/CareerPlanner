import 'package:careerplanner/model/news/article_object.dart';
import 'package:careerplanner/ui/shared/loading_image.dart';
import 'package:careerplanner/ui/shared/web_view_container.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class NewsDetailWidget extends StatelessWidget {
  final ArticleObject article;

  const NewsDetailWidget({Key key, this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CareerPlannerTheme.neutralBackground,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            elevation: 24,
            automaticallyImplyLeading: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.27,
            stretch: true,
            backgroundColor: CareerPlannerTheme.primaryColor,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.srcOver),
                      child: LoadingImage(
                          url: article.imagePath,
                          heroTag: "article_image_${article.id}"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${article.title}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
              child: WebViewContainer(
            url: article.link,
            allowFollowLink: false,
          ))
        ]));
  }
}

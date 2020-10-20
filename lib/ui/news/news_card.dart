import 'package:careerplanner/model/news/article_object.dart';
import 'package:careerplanner/ui/shared/loading_image.dart';
import 'package:careerplanner/util/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCard extends StatelessWidget {
  final ArticleObject article;
  const NewsCard({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.newsDetailRoute,
              arguments: article);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Container(
                              color: Theme.of(context).primaryColor,
                              child: LoadingImage(
                                  url: article.imagePath,
                                  heroTag: "article_image_${article.id}")),
                        ],
                      ))),
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      article.title,
                      style: GoogleFonts.robotoSlabTextTheme()
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Text(
                    article.link,
                    style: GoogleFonts.robotoSlabTextTheme().caption,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ],
              ))
            ],
          ),
        ));
  }
}

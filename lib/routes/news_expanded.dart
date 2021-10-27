import 'package:flutter/material.dart';
import 'package:the_voyager_project/apis/news_api.dart';
import 'package:the_voyager_project/routes/news_webview.dart';

class ExpandedNews extends StatefulWidget {
  final NewsData currentNews;
  final int heroIndex;
  const ExpandedNews(
      {Key? key, required this.currentNews, required this.heroIndex})
      : super(key: key);

  @override
  _ExpandedNewsState createState() => _ExpandedNewsState();
}

class _ExpandedNewsState extends State<ExpandedNews>
    with AutomaticKeepAliveClientMixin<ExpandedNews> {
  late double deviceHeight;
  late double deviceWidth;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: const Color(0xFF111111),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              expandedHeight: deviceHeight / 2,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                titlePadding: const EdgeInsets.all(0),
                background: Hero(
                  tag: "image${widget.heroIndex}",
                  child: Image.network(
                    widget.currentNews.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == 0) {
                    return Material(
                      type: MaterialType.transparency,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 50.0, left: 25.0, right: 25.0, bottom: 50.0),
                        child: SizedBox(
                          width: deviceWidth,
                          child: Hero(
                            tag: "title${widget.heroIndex}",
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                widget.currentNews.title!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    return Material(
                      type: MaterialType.transparency,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, bottom: 50.0),
                        child: SizedBox(
                          width: deviceWidth,
                          child: Text(
                            widget.currentNews.content!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Material(
                      type: MaterialType.transparency,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: 25.0, left: 25.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: deviceWidth - 25,
                                      child: Text(
                                        widget.currentNews.author!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: deviceWidth - 25,
                                      child: Text(
                                        widget.currentNews.time!,
                                        style: TextStyle(
                                          color: Colors.grey[350],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: deviceWidth - 25,
                                      child: Text(
                                        widget.currentNews.date!,
                                        style: TextStyle(
                                          color: Colors.grey[350],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsWebView(
                                          sauce:
                                              widget.currentNews.readMoreUrl!),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.white30,
                                  ),
                                ),
                                child: const Text(
                                  "Source",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                childCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

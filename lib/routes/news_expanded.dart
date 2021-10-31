import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:the_voyager_project/apis/news_api.dart';
import 'package:the_voyager_project/routes/fullscreen_image.dart';
import 'package:the_voyager_project/routes/news_webview.dart';
import 'package:the_voyager_project/widgets/custom_physics.dart';

class NewsTabView extends StatefulWidget {
  final List<NewsData> allNews;
  final int newsIndex;
  const NewsTabView({Key? key, required this.allNews, required this.newsIndex})
      : super(key: key);

  @override
  _NewsTabViewState createState() => _NewsTabViewState();
}

class _NewsTabViewState extends State<NewsTabView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        vsync: this,
        length: widget.allNews.length,
        initialIndex: widget.newsIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const CustomPhysics(),
      controller: _tabController,
      children: [
        for (int i = 0; i < widget.allNews.length; i++)
          ExpandedNews(currentNews: widget.allNews[i], heroIndex: i),
      ],
    );
  }
}

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
  late ScrollController _scrollBarController;

  @override
  void initState() {
    _scrollBarController = ScrollController();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // body: CustomScrollView(
      //   physics: const BouncingScrollPhysics(),
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       backgroundColor: Colors.black,
      //       iconTheme: const IconThemeData(
      //         color: Colors.white,
      //       ),
      //       expandedHeight: deviceHeight / 2,
      //       flexibleSpace: FlexibleSpaceBar(
      //         collapseMode: CollapseMode.parallax,
      //         titlePadding: const EdgeInsets.all(0),
      //         background: Hero(
      //           tag: "image${widget.heroIndex}",
      //           child: Image.network(
      //             widget.currentNews.imageUrl!,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //     ),
      //     SliverList(
      //       delegate: SliverChildBuilderDelegate(
      //         (BuildContext context, int index) {
      //           if (index == 0) {
      //             return Material(
      //               type: MaterialType.transparency,
      //               child: Padding(
      //                 padding: const EdgeInsets.only(
      //                     top: 50.0, left: 25.0, right: 25.0, bottom: 50.0),
      //                 child: SizedBox(
      //                   width: deviceWidth,
      //                   child: Hero(
      //                     tag: "title${widget.heroIndex}",
      //                     child: Material(
      //                       type: MaterialType.transparency,
      //                       child: Text(
      //                         widget.currentNews.title!,
      //                         style: const TextStyle(
      //                           fontStyle: FontStyle.italic,
      //                           fontWeight: FontWeight.w700,
      //                           fontSize: 26,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             );
      //           } else if (index == 1) {
      //             return Material(
      //               type: MaterialType.transparency,
      //               child: Padding(
      //                 padding: const EdgeInsets.only(
      //                     left: 25.0, right: 25.0, bottom: 50.0),
      //                 child: SizedBox(
      //                   width: deviceWidth,
      //                   child: Text(
      //                     widget.currentNews.content!,
      //                     style: const TextStyle(
      //                       fontSize: 22,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             );
      //           } else {
      //             return widget.currentNews.category == "space"
      //                 ? Material(
      //                     type: MaterialType.transparency,
      //                     child: Padding(
      //                       padding:
      //                           const EdgeInsets.only(bottom: 25.0, left: 25.0),
      //                       child: Column(
      //                         children: [
      //                           Row(
      //                             mainAxisAlignment: MainAxisAlignment.start,
      //                             children: [
      //                               Column(
      //                                 children: [
      //                                   SizedBox(
      //                                     width: deviceWidth - 25,
      //                                     child: Text(
      //                                       widget.currentNews.date!,
      //                                       style: TextStyle(
      //                                         color: Colors.grey[350],
      //                                         fontSize: 14,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ],
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets.only(top: 50.0),
      //                             child: TextButton(
      //                               onPressed: () {
      //                                 Navigator.push(
      //                                   context,
      //                                   MaterialPageRoute(
      //                                     builder: (context) => NewsWebView(
      //                                         sauce: widget
      //                                             .currentNews.readMoreUrl!),
      //                                   ),
      //                                 );
      //                               },
      //                               style: ButtonStyle(
      //                                 overlayColor: MaterialStateProperty.all(
      //                                   Colors.white30,
      //                                 ),
      //                               ),
      //                               child: const Text(
      //                                 "Source",
      //                                 style: TextStyle(
      //                                     color: Colors.white, fontSize: 16),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   )
      //                 : Material(
      //                     type: MaterialType.transparency,
      //                     child: Padding(
      //                       padding:
      //                           const EdgeInsets.only(bottom: 25.0, left: 25.0),
      //                       child: Column(
      //                         children: [
      //                           Row(
      //                             mainAxisAlignment: MainAxisAlignment.start,
      //                             children: [
      //                               Column(
      //                                 children: [
      //                                   SizedBox(
      //                                     width: deviceWidth - 25,
      //                                     child: Text(
      //                                       widget.currentNews.author!,
      //                                       style: const TextStyle(
      //                                         fontSize: 18,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                   SizedBox(
      //                                     width: deviceWidth - 25,
      //                                     child: Text(
      //                                       widget.currentNews.time!,
      //                                       style: const TextStyle(
      //                                         fontSize: 14,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                   SizedBox(
      //                                     width: deviceWidth - 25,
      //                                     child: Text(
      //                                       widget.currentNews.date!,
      //                                       style: const TextStyle(
      //                                         fontSize: 14,
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ],
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets.only(top: 50.0),
      //                             child: Material(
      //                               type: MaterialType.transparency,
      //                               child: TextButton(
      //                                 onPressed: () {
      //                                   Navigator.push(
      //                                     context,
      //                                     MaterialPageRoute(
      //                                       builder: (context) => NewsWebView(
      //                                           sauce: widget
      //                                               .currentNews.readMoreUrl!),
      //                                     ),
      //                                   );
      //                                 },
      //                                 // style: ButtonStyle(
      //                                 //   overlayColor: MaterialStateProperty.all(
      //                                 //     Colors.white30,
      //                                 //   ),
      //                                 // ),
      //                                 child: const Text(
      //                                   "Source",
      //                                   style: TextStyle(fontSize: 16),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   );
      //           }
      //         },
      //         childCount: 3,
      //       ),
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Hero(
            tag: "image${widget.heroIndex}",
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.currentNews.imageUrl!),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: deviceHeight / 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Scrollbar(
            controller: _scrollBarController,
            child: SingleChildScrollView(
              controller: _scrollBarController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: deviceHeight / 1.5,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 120),
                            reverseDuration: const Duration(milliseconds: 120),
                            child: FullScreenImage(
                              imageLink: widget.currentNews.imageUrl!,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
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
                  Padding(
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
                  widget.currentNews.category == "space"
                      ? Padding(
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
                                            sauce: widget
                                                .currentNews.readMoreUrl!),
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
                        )
                      : Padding(
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
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: deviceWidth - 25,
                                        child: Text(
                                          widget.currentNews.date!,
                                          style: const TextStyle(
                                            color: Colors.white,
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
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewsWebView(
                                              sauce: widget
                                                  .currentNews.readMoreUrl!),
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
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

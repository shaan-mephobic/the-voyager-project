import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:the_voyager_project/apis/news_api.dart';
import 'package:the_voyager_project/logic/hive_db.dart';
import 'package:the_voyager_project/routes/news_expanded.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin<NewsScreen> {
  late ScrollController _scrollBarController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late double deviceHeight;
  late bool isDarkMode;
  late double deviceWidth;
  List<NewsData> news = [];
  final Duration pageTransitionSpeed = const Duration(milliseconds: 200);
  bool isRefreshing = true;
  bool isRefreshInterrupt = false;
  final List<String> newsCategories = const [
    "Science",
    "Technology",
    "Space",
    "World",
    "Indian",
    "Business",
    "Sports",
    "Politics",
    "Startup",
    "Entertainment",
    "Automobile",
    "Hatke",
    "Miscellaneous"
  ];
  List<bool> newsTagChips = voyagerBox.get("selectedNewsTags") ??
      List.generate(13, (index) => index == 0 ? true : false);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _scrollBarController = ScrollController();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<NewsData>> fetchNews() async {
    debugPrint("going in going in going in");
    return await News().fetchNews(
        science: newsTagChips[0],
        technology: newsTagChips[1],
        space: newsTagChips[2],
        world: newsTagChips[3],
        indian: newsTagChips[4],
        business: newsTagChips[5],
        sports: newsTagChips[6],
        politics: newsTagChips[7],
        startup: newsTagChips[8],
        entertainment: newsTagChips[9],
        automobile: newsTagChips[10],
        hatke: newsTagChips[11],
        miscellaneous: newsTagChips[12]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body:
          // Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     fit: BoxFit.cover,
          //     image: AssetImage("assets/res/home.jpg"),
          //   ),
          // ),
          // color: const Color(0xFF111111)
          // child:
          Scrollbar(
        controller: _scrollBarController,
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          backgroundColor: const Color(0xFF272C31),
          color: Colors.white,
          onRefresh: () async {
            isRefreshing = true;
            news = await fetchNews();
            setState(() {});
            isRefreshing = false;
            if (isRefreshInterrupt) {
              isRefreshInterrupt = false;
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                _refreshIndicatorKey.currentState?.show();
              });
            }
          },
          child: ListView.builder(
            controller: _scrollBarController,
            itemCount: news.length + 1,
            padding: EdgeInsets.only(top: deviceHeight / 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      for (int i = 0; i < newsCategories.length; i++)
                        ChoiceChip(
                          label: Text(newsCategories[i]),
                          selectedColor: const Color(0xFF090026),
                          selected: newsTagChips[i],
                          onSelected: (bool value) {
                            setState(() {
                              newsTagChips[i] = value;
                            });
                            isRefreshInterrupt = isRefreshing;
                            SchedulerBinding.instance!
                                .addPostFrameCallback((_) {
                              _refreshIndicatorKey.currentState?.show();
                            });
                          },
                        ),
                    ],
                  ),
                );
              } else if (index == 1) {
                return SizedBox(
                  width: deviceWidth,
                  height: deviceHeight / 1.8,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: deviceWidth / 9,
                        right: deviceWidth / 9,
                        bottom: 20),
                    child: AspectRatio(
                      aspectRatio: 10 / 16,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                alignment: Alignment.center,
                                duration: pageTransitionSpeed,
                                reverseDuration: pageTransitionSpeed,
                                child: NewsTabView(
                                  allNews: news,
                                  newsIndex: index - 1,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Hero(
                                tag: "image${index - 1}",
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        news[index - 1].imageUrl!,
                                      ),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          alignment: Alignment.center,
                                          duration: pageTransitionSpeed,
                                          reverseDuration: pageTransitionSpeed,
                                          child: NewsTabView(
                                            allNews: news,
                                            newsIndex: index - 1,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  height: deviceHeight / 1.8 / 2,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black87,
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: deviceWidth / 15,
                                      right: deviceWidth / 15,
                                      bottom: deviceHeight / 1.8 / 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Hero(
                                          tag: "title${index - 1}",
                                          child: Material(
                                            type: MaterialType.transparency,
                                            child: Text(
                                              news[index - 1].title!,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              news[index - 1].category ==
                                                      "space"
                                                  ? news[index - 1].date!
                                                  : news[index - 1]
                                                      .date!
                                                      .replaceRange(
                                                          news[index - 1]
                                                              .date!
                                                              .indexOf(","),
                                                          news[index - 1]
                                                              .date!
                                                              .length,
                                                          ""),
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 130,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(0xFF0f0f0f)
                          : Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                alignment: Alignment.center,
                                duration: pageTransitionSpeed,
                                reverseDuration: pageTransitionSpeed,
                                child: NewsTabView(
                                  allNews: news,
                                  newsIndex: index - 1,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Hero(
                                tag: "image${index - 1}",
                                child: Container(
                                  height: 110,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        news[index - 1].imageUrl!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: deviceWidth / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Hero(
                                      tag: "title${index - 1}",
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: Text(
                                          news[index - 1].title!,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          news[index - 1].category == "space"
                                              ? news[index - 1].date!
                                              : news[index - 1]
                                                  .date!
                                                  .replaceRange(
                                                      news[index - 1]
                                                          .date!
                                                          .indexOf(","),
                                                      news[index - 1]
                                                          .date!
                                                          .length,
                                                      ""),
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

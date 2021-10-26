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
  late double deviceWidth;
  List<NewsData> news = [];
  final Duration pageTransitionSpeed = const Duration(milliseconds: 200);
  final List<String> newsCategories = const [
    "Science",
    "Technology",
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
      List.generate(12, (index) => index == 0 || index == 1 ? true : false);

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
        world: newsTagChips[2],
        indian: newsTagChips[3],
        business: newsTagChips[4],
        sports: newsTagChips[5],
        politics: newsTagChips[6],
        startup: newsTagChips[7],
        entertainment: newsTagChips[8],
        automobile: newsTagChips[9],
        hatke: newsTagChips[10],
        miscellaneous: newsTagChips[11]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: const Text(
      //     "VOYAGER",
      //     style: TextStyle(
      //         fontFamily: "VerminVibes", fontSize: 38, color: Colors.white),
      //   ),
      // ),
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.cover,
        //     image: AssetImage("assets/res/home.jpg"),
        //   ),
        // ),
        color: const Color(0xFF111111),
        child: Scrollbar(
          controller: _scrollBarController,
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            backgroundColor: const Color(0xFF272C31),
            color: Colors.white,
            onRefresh: () async {
              news = await fetchNews();
              setState(() {});
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
                            selected: newsTagChips[i],
                            onSelected: (bool value) {
                              setState(() {
                                newsTagChips[i] = value;
                                SchedulerBinding.instance!
                                    .addPostFrameCallback((_) {
                                  _refreshIndicatorKey.currentState?.show();
                                });
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
                          child: Stack(
                            children: [
                              Hero(
                                tag: news[index - 1].imageUrl!,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      // image: AssetImage("assets/res/home.jpg"),
                                      image: NetworkImage(
                                        news[index - 1].imageUrl!,
                                      ),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          alignment: Alignment.center,
                                          duration: pageTransitionSpeed,
                                          reverseDuration: pageTransitionSpeed,
                                          child: ExpandedNews(
                                            currentNews: news[index - 1],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    height: 150,
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.02),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  alignment: Alignment.center,
                                                  duration: pageTransitionSpeed,
                                                  reverseDuration:
                                                      pageTransitionSpeed,
                                                  child: ExpandedNews(
                                                    currentNews:
                                                        news[index - 1],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: deviceWidth / 15,
                                                right: deviceWidth / 15,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    news[index - 1].title!,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        news[index - 1]
                                                            .date!
                                                            .replaceRange(
                                                                news[index - 1]
                                                                    .date!
                                                                    .indexOf(
                                                                        ","),
                                                                news[index - 1]
                                                                    .date!
                                                                    .length,
                                                                ""),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              type: MaterialType.transparency,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      alignment: Alignment.center,
                                      duration: pageTransitionSpeed,
                                      reverseDuration: pageTransitionSpeed,
                                      child: ExpandedNews(
                                        currentNews: news[index - 1],
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Hero(
                                      tag: news[index - 1].imageUrl!,
                                      child: Container(
                                        height: 110,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            news[index - 1].title!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                news[index - 1]
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
                                                    color: Colors.white,
                                                    fontSize: 10),
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
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

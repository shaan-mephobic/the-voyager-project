import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_remixicon/flutter_remixicon.dart';
import 'package:the_voyager_project/apis/mars_weather.dart';
// import 'package:page_transition/page_transition.dart';

class MarsPage extends StatefulWidget {
  const MarsPage({Key? key}) : super(key: key);

  @override
  _MarsPageState createState() => _MarsPageState();
}

class _MarsPageState extends State<MarsPage> {
  late double deviceHeight;
  late double deviceWidth;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final Color marsColor = const Color(0xFFA12A21);
  MarsWeatherData? header;
  late ScrollController _scrollBarController;
  List<MarsWeatherData> mars = [];

  @override
  void initState() {
    _scrollBarController = ScrollController();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
    super.initState();
  }

  fetchMars() async {
    debugPrint("hey hey hey hey");
    mars = await MarsWeather().fetchWeather();
    for (int i = mars.length - 1; i >= 0; i--) {
      if (mars[i].maxTemp != "--") {
        header = mars[i];
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/res/marsurface.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scrollbar(
          controller: _scrollBarController,
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            backgroundColor: const Color(0xFF272C31),
            color: Colors.white,
            onRefresh: () async {
              await fetchMars();
              setState(() {});
            },
            child: header != null
                ? SizedBox(
                    width: deviceWidth,
                    height: deviceHeight,
                    child: SingleChildScrollView(
                      controller: _scrollBarController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: deviceHeight / 10, left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Mars",
                                      style: TextStyle(
                                        color: marsColor,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 46,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Material(
                                      type: MaterialType.transparency,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          onTap: () async {
                                            // await Navigator.push(
                                            //   context,
                                            //   PageTransition(
                                            //     type: PageTransitionType.size,
                                            //     alignment: Alignment.center,
                                            //     duration:
                                            //         const Duration(milliseconds: 200),
                                            //     reverseDuration:
                                            //         const Duration(milliseconds: 200),
                                            //     // child: const QuakeSettings(),
                                            //   ),
                                            // ).then((value) async {
                                            //   if (value) {
                                            //     SchedulerBinding.instance!
                                            //         .addPostFrameCallback((_) {
                                            //       _refreshIndicatorKey.currentState
                                            //           ?.show();
                                            //     });
                                            //   }
                                            // });
                                          },
                                          child: const Icon(
                                            MIcon.riSettingsLine,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Weather",
                                  style: TextStyle(
                                    color: Colors.orange[100],
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: deviceHeight / 10, left: 20),
                                child: Text(
                                  "${header!.maxTemp}°C ${header!.minTemp}°C",
                                  style: TextStyle(
                                    color: marsColor,
                                    fontSize: deviceHeight / 18,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       top: deviceHeight / 10,
                          //       left: 20,
                          //       right: 20,
                          //       bottom: deviceHeight / 10),
                          //   child: SizedBox(
                          //     width: double.infinity,
                          //     child: AspectRatio(
                          //       aspectRatio: 4 / 3,
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: Colors.black.withOpacity(0.1),
                          //               blurRadius: 13,
                          //               offset: const Offset(0, 3),
                          //             ),
                          //           ],
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //         child: ClipRRect(
                          //           borderRadius: BorderRadius.circular(10),
                          //           child: BackdropFilter(
                          //             filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          //             child: Container(
                          //               color: Colors.black12,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}

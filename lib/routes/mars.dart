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

class _MarsPageState extends State<MarsPage>
    with AutomaticKeepAliveClientMixin<MarsPage> {
  late double deviceHeight;
  late double deviceWidth;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final Color marsColor = const Color(0xFFA12A21);
  final Color marsWhite = const Color(0xFFEEEEEE);
  MarsWeatherData? header;
  late ScrollController _scrollBarController;
  List<MarsWeatherData> mars = [];
  List<String> tableHeader = [
    "Sol",
    "Earth date",
    "Min-Temp",
    "Max-Temp",
    "Pressure",
    "Sunrise",
    "Sunset",
    "Ls",
    "Season",
  ];

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
    super.build(context);
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
                                        borderRadius: BorderRadius.circular(25),
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
                                        child: Icon(
                                          MIcon.riSettingsLine,
                                          size: 40,
                                          color: marsWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Weather",
                                style: TextStyle(
                                  color: marsWhite,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: deviceHeight / 8, left: 20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                color: marsWhite,
                                size: deviceHeight / 22,
                              ),
                              Text(
                                " ${header!.maxTemp}°C",
                                style: TextStyle(
                                  color: marsWhite,
                                  fontWeight: FontWeight.w600,
                                  fontSize: deviceHeight / 22,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_downward,
                                color: marsWhite,
                                size: deviceHeight / 22,
                              ),
                              Text(
                                " ${header!.minTemp}°C",
                                style: TextStyle(
                                  color: marsWhite,
                                  fontWeight: FontWeight.w600,
                                  fontSize: deviceHeight / 22,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 100,
                            left: 10,
                            right: 10,
                            bottom: 200,
                          ),
                          child: SizedBox(
                            height: deviceHeight / 3,
                            width: deviceWidth,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: [
                                    for (int i = 0; i < tableHeader.length; i++)
                                      DataColumn(
                                        label: Text(
                                          tableHeader[i],
                                          style: TextStyle(
                                            fontSize: 21,
                                            color: Colors.grey[100],
                                          ),
                                        ),
                                      ),
                                  ],
                                  rows: [
                                    for (int i = mars.length - 1; i >= 0; i--)
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              mars[i].sol!,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: marsColor,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              mars[i].terrestrialDate!,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: marsWhite,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              mars[i].minTemp!,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: marsWhite,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              mars[i].maxTemp!,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: marsWhite,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              mars[i].pressure!,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: marsWhite,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              mars[i].sunrise!,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: marsWhite,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              mars[i].sunset!,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: marsWhite,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              mars[i].ls!,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: marsWhite,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              mars[i].season!,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: marsWhite,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
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
    );
  }
}

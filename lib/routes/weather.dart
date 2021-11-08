import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:the_voyager_project/apis/weather_api.dart';

class MoonPage extends StatefulWidget {
  const MoonPage({Key? key}) : super(key: key);

  @override
  _MoonPageState createState() => _MoonPageState();
}

class _MoonPageState extends State<MoonPage>
    with AutomaticKeepAliveClientMixin<MoonPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late double deviceHeight;
  late double deviceWidth;
  WeatherData? weather;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/res/stars.jpg"),
          ),
        ),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          backgroundColor: const Color(0xFF272C31),
          color: Colors.white,
          onRefresh: () async {
            weather = await Weather().fetchWeather(null);
            // weather = WeatherData(moonDay: "2", moonPhase: "🌔");
            setState(() {});
          },
          child: weather != null
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight / 6),
                        child: Container(
                          width: deviceWidth / 2,
                          height: deviceWidth / 2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(moonType()),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight / 25),
                        child: Text(
                          "Moon day - ${weather?.moonDay}",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: deviceHeight / 10,
                            left: 20,
                            right: 20,
                            bottom: deviceHeight / 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 13,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                    color: Colors.white.withOpacity(0.06),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, top: 25.0),
                                              child: Text(
                                                "DETAILS",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: deviceWidth / 2 - 20,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Dusk",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${weather?.dusk}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Sunset",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${weather?.sunset}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Weather",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${weather?.weatherCondition}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: deviceWidth / 2 - 20,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Dawn",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${weather?.dawn}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Sunrise",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${weather?.sunrise}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Temperature",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${weather?.temperature}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
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
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  String moonType() {
    //🌑🌒🌓🌔🌕🌖🌗🌘
    debugPrint(weather?.moonPhase);
    switch (weather?.moonPhase) {
      case ("🌑"):
        return "assets/res/moons-1.png";
      case ("🌒"):
        return "assets/res/moons-2.png";
      case ("🌓"):
        return "assets/res/moons-3.png";
      case ("🌔"):
        return "assets/res/moons-4.png";
      case ("🌕"):
        return "assets/res/moons-5.png";
      case ("🌖"):
        return "assets/res/moons-6.png";
      case ("🌗"):
        return "assets/res/moons-7.png";
      default: // ("🌘"):
        return "assets/res/moons-8.png";
    }
  }
}

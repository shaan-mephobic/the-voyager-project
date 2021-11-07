import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
import 'package:the_voyager_project/apis/earthquake_api.dart';
import 'package:flutter_remixicon/flutter_remixicon.dart';
// import 'package:the_voyager_project/logic/fetch_weather.dart';
// import 'package:the_voyager_project/provider/quake_state.dart';
import 'package:the_voyager_project/widgets/dialogues/quake_settings.dart';

class QuakeScreen extends StatefulWidget {
  const QuakeScreen({Key? key}) : super(key: key);

  @override
  _QuakeScreenState createState() => _QuakeScreenState();
}

class _QuakeScreenState extends State<QuakeScreen>
    with AutomaticKeepAliveClientMixin<QuakeScreen> {
  late double deviceHeight;
  late double deviceWidth;
  List<EarthquakeData> earthquakes = [];
  late ScrollController _scrollBarController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

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

  Future<void> fetchEarthquakes() async {
    earthquakes = await Earthquake().quakesCheck();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/res/earthquake.jpg'),
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
              await fetchEarthquakes();
            },
            child: ListView.builder(
              controller: _scrollBarController,
              physics: const BouncingScrollPhysics(),
              itemCount: earthquakes.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: deviceHeight / 10, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Earthquake",
                              style: TextStyle(
                                color: Color(0xFF272C31),
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
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(25),
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.size,
                                        alignment: Alignment.center,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        reverseDuration:
                                            const Duration(milliseconds: 200),
                                        child: const QuakeSettings(),
                                      ),
                                    ).then((value) async {
                                      if (value) {
                                        SchedulerBinding.instance!
                                            .addPostFrameCallback((_) {
                                          _refreshIndicatorKey.currentState
                                              ?.show();
                                        });
                                      }
                                    });
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
                        const Text(
                          "Warning",
                          style: TextStyle(
                            color: Color(0xFFCF2941),
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (index == 1) {
                  return Padding(
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
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                color: Colors.black12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 62,
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
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          color: Colors.black12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                // padding: const EdgeInsets.only(left: 20.0),
                                padding: const EdgeInsets.only(left: 0.0),

                                child: SizedBox(
                                  width: deviceWidth / 1.28,

                                  /// TODO fix padding
                                  child: Text(
                                    earthquakes.isNotEmpty
                                        ? earthquakes[index - 2].location!
                                        : "",
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                // padding: const EdgeInsets.only(right: 20.0),
                                padding: const EdgeInsets.only(left: 0.0),

                                child: Text(
                                  earthquakes.isNotEmpty
                                      ? earthquakes[index - 2]
                                                  .magnitude!
                                                  .length >
                                              2
                                          ? earthquakes[index - 2]
                                              .magnitude!
                                              .substring(0, 3)
                                          : earthquakes[index - 2].magnitude!
                                      : "",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

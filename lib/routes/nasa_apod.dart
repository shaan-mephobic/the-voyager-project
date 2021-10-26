///Image of the day from Nasa. All credits for the data to NASA.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:the_voyager_project/apis/apod_api.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_view/photo_view.dart';

class NasaApod extends StatefulWidget {
  const NasaApod({Key? key}) : super(key: key);

  @override
  _NasaApodState createState() => _NasaApodState();
}

class _NasaApodState extends State<NasaApod> with AutomaticKeepAliveClientMixin<NasaApod> {
  late ScrollController _scrollBarController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late double deviceHeight;
  late double deviceWidth;
  ApodData apod = ApodData();
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

  fetchData() async {
    print("hot hot hot  hot");
    return await AstronomyPictureOfTheDay().fetchData(
        day: DateTime.now().day,
        month: DateTime.now().month,
        year: DateTime.now().year);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "VOYAGER",
          style: TextStyle(
              fontFamily: "VerminVibes", fontSize: 38, color: Colors.white),
        ),
      ),
      body: Builder(builder: (context) {
        return Stack(
          children: [
            apod.mediaType == "video"
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          apod.imageThumbnail.toString().startsWith("http")
                              ? apod.imageThumbnail!
                              : "https://${apod.imageThumbnail!}",
                        ),
                      ),
                    ),
                  )
                : apod.mediaUrl == null
                    ? Container(color: Colors.black)
                    : Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(apod.mediaUrl!),
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
                      Colors.black87,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Scrollbar(
              controller: _scrollBarController,
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                backgroundColor: const Color(0xFF272C31),
                color: Colors.white,
                onRefresh: () async {
                  apod = await fetchData();
                  setState(() {});
                },
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
                                reverseDuration:
                                    const Duration(milliseconds: 120),
                                child: ApodFullscreen(
                                  imageLink: apod.mediaType == "video"
                                      ? apod.imageThumbnail
                                              .toString()
                                              .startsWith("http")
                                          ? apod.imageThumbnail
                                          : "https://${apod.imageThumbnail}"
                                      : apod.mediaUrl,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            apod.title ?? "",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: HTML.toRichText(
                              context, apod.description ?? "",
                              overrideStyle: {
                                "a": const TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.none),
                              },
                              defaultTextStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              linksCallback: (link) async =>
                                  await canLaunch(link)
                                      ? await launch(link)
                                      : throw 'Could not launch $link'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 60.0, left: 30, right: 30, bottom: 10),
                        child: SizedBox(
                          width: deviceWidth,
                          child: Text(
                            apod.copyright ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ApodFullscreen extends StatelessWidget {
  final String? imageLink;
  const ApodFullscreen({Key? key, @required this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageLink!),
        ),
      ),
      child: BackdropFilter(
        filter:
            ImageFilter.blur(tileMode: TileMode.mirror, sigmaX: 25, sigmaY: 25),
        child: PhotoView(
          imageProvider: NetworkImage(imageLink!),
          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
        ),
      ),
    );
  }
}

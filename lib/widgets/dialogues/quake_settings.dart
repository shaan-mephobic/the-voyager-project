import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_voyager_project/logic/hive_db.dart';
import 'package:the_voyager_project/widgets/snackbar.dart';

class QuakeSettings extends StatefulWidget {
  const QuakeSettings({Key? key}) : super(key: key);

  @override
  _QuakeSettingsState createState() => _QuakeSettingsState();
}

class _QuakeSettingsState extends State<QuakeSettings> {
  late double deviceHeight;
  late double deviceWidth;
  Map quakeDb = voyagerBox.get("quakeDb") ?? {};
  String? minMag;
  String? startDay;
  String? startMonth;
  String? startYear;
  String? endDay;
  String? endMonth;
  String? endYear;
  bool hasValChanged = false;

  @override
  void initState() {
    minMag = quakeDb['minMagnitude']?.toString();
    startDay = quakeDb['startDay']?.toString();
    startMonth = quakeDb['startMonth']?.toString();
    startYear = quakeDb['startYear']?.toString();
    endDay = quakeDb['endDay']?.toString();
    endMonth = quakeDb['endMonth']?.toString();
    endYear = quakeDb['endYear']?.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context, hasValChanged);
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 4 / 5,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Material(
                              type: MaterialType.transparency,
                              child: Text(
                                "Options",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 31,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      const Text("Start",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            height: 70,
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller:
                                                  TextEditingController()
                                                    ..text = startYear ?? ""
                                                    ..selection =
                                                        TextSelection.collapsed(
                                                            offset: startYear
                                                                    ?.length ??
                                                                0),
                                              decoration: const InputDecoration(
                                                labelText: "yyyy",
                                                labelStyle: TextStyle(
                                                  color: Colors.white38,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                counterText: "",
                                              ),
                                              onChanged: (changes) {
                                                hasValChanged = true;
                                                setState(() {
                                                  startYear = changes.length > 4
                                                      ? changes.replaceRange(
                                                          4, changes.length, '')
                                                      : changes;
                                                  startYear = startYear == ""
                                                      ? null
                                                      : startYear;
                                                });
                                              },
                                              maxLength: 4,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10)),
                                          SizedBox(
                                            width: 40,
                                            height: 70,
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              controller:
                                                  TextEditingController()
                                                    ..text = startMonth ?? ""
                                                    ..selection =
                                                        TextSelection.collapsed(
                                                            offset: startMonth
                                                                    ?.length ??
                                                                0),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              decoration: const InputDecoration(
                                                labelText: "mm",
                                                labelStyle: TextStyle(
                                                  color: Colors.white38,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                counterText: "",
                                              ),
                                              onChanged: (changes) {
                                                hasValChanged = true;
                                                setState(() {
                                                  startMonth = changes.length >
                                                          2
                                                      ? changes.replaceRange(
                                                          2, changes.length, "")
                                                      : changes;
                                                  startMonth = startMonth == ""
                                                      ? null
                                                      : startMonth;
                                                });
                                              },
                                              maxLength: 2,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10)),
                                          SizedBox(
                                            width: 40,
                                            height: 70,
                                            child: TextField(
                                                textAlign: TextAlign.center,
                                                controller:
                                                    TextEditingController()
                                                      ..text = startDay ?? ""
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: startDay
                                                                      ?.length ??
                                                                  0),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "dd",
                                                  labelStyle: TextStyle(
                                                    color: Colors.white38,
                                                  ),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  counterText: "",
                                                ),
                                                onChanged: (changes) {
                                                  hasValChanged = true;
                                                  setState(() {
                                                    startDay = changes.length >
                                                            2
                                                        ? changes.replaceRange(
                                                            2,
                                                            changes.length,
                                                            "")
                                                        : changes;
                                                    startDay = startDay == ""
                                                        ? null
                                                        : startDay;
                                                  });
                                                },
                                                maxLength: 2,
                                                keyboardType:
                                                    TextInputType.number),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      const Text("End",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            height: 70,
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller:
                                                  TextEditingController()
                                                    ..text = endYear ?? ""
                                                    ..selection =
                                                        TextSelection.collapsed(
                                                            offset: endYear
                                                                    ?.length ??
                                                                0),
                                              decoration: const InputDecoration(
                                                labelText: "yyyy",
                                                labelStyle: TextStyle(
                                                  color: Colors.white38,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                counterText: "",
                                              ),
                                              onChanged: (changes) {
                                                hasValChanged = true;

                                                setState(() {
                                                  endYear = changes.length > 4
                                                      ? changes.replaceRange(
                                                          4, changes.length, '')
                                                      : changes;
                                                  endYear = endYear == ""
                                                      ? null
                                                      : endYear;
                                                });
                                              },
                                              maxLength: 4,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10)),
                                          SizedBox(
                                            width: 40,
                                            height: 70,
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              controller:
                                                  TextEditingController()
                                                    ..text = endMonth ?? ""
                                                    ..selection =
                                                        TextSelection.collapsed(
                                                            offset: endMonth
                                                                    ?.length ??
                                                                0),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              decoration: const InputDecoration(
                                                labelText: "mm",
                                                labelStyle: TextStyle(
                                                  color: Colors.white38,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                counterText: "",
                                              ),
                                              onChanged: (changes) {
                                                hasValChanged = true;
                                                setState(() {
                                                  endMonth = changes.length > 2
                                                      ? changes.replaceRange(
                                                          2, changes.length, "")
                                                      : changes;
                                                  endMonth = endMonth == ""
                                                      ? null
                                                      : endMonth;
                                                });
                                              },
                                              maxLength: 2,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10)),
                                          SizedBox(
                                            width: 40,
                                            height: 70,
                                            child: TextField(
                                                textAlign: TextAlign.center,
                                                controller:
                                                    TextEditingController()
                                                      ..text = endDay ?? ""
                                                      ..selection = TextSelection
                                                          .collapsed(
                                                              offset: endDay
                                                                      ?.length ??
                                                                  0),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "dd",
                                                  labelStyle: TextStyle(
                                                    color: Colors.white38,
                                                  ),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  counterText: "",
                                                ),
                                                onChanged: (changes) {
                                                  hasValChanged = true;
                                                  setState(() {
                                                    endDay = changes.length > 2
                                                        ? changes.replaceRange(
                                                            2,
                                                            changes.length,
                                                            "")
                                                        : changes;
                                                    endDay = endDay == ""
                                                        ? null
                                                        : endDay;
                                                  });
                                                },
                                                maxLength: 2,
                                                keyboardType:
                                                    TextInputType.number),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  const Text("Minimum magnitude",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 70,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          controller: TextEditingController()
                                            ..text = minMag ?? ""
                                            ..selection =
                                                TextSelection.collapsed(
                                                    offset:
                                                        minMag?.length ?? 0),
                                          decoration: const InputDecoration(
                                            labelText: "mag",
                                            labelStyle: TextStyle(
                                              color: Colors.white38,
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            counterText: "",
                                          ),
                                          onChanged: (changes) {
                                            hasValChanged = true;
                                            setState(() {
                                              minMag = changes.length > 3
                                                  ? changes.replaceRange(
                                                      3, changes.length, '')
                                                  : changes;
                                              minMag =
                                                  minMag == "" ? null : minMag;
                                            });
                                          },
                                          maxLength: 3,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (hasValChanged) {
                                  if ((startYear != null &&
                                          startMonth != null &&
                                          startDay != null) &&
                                      ((endYear != null &&
                                              endMonth != null &&
                                              endDay != null) ||
                                          (endYear == null &&
                                              endMonth == null &&
                                              endDay == null))) {
                                    if (double.parse(minMag ?? "5") > 10) {
                                      Flushbars().error(context,
                                          "Magnitude can't be greater than 10");
                                    } else {
                                      Navigator.pop(context, hasValChanged);
                                      await HiveDB().setQuake(
                                        {
                                          'endDay': endDay != null
                                              ? int.parse(endDay!)
                                              : null,
                                          'endMonth': endMonth != null
                                              ? int.parse(endMonth!)
                                              : null,
                                          'endYear': endYear != null
                                              ? int.parse(endYear!)
                                              : null,
                                          'startDay': startDay != null
                                              ? int.parse(startDay!)
                                              : null,
                                          'startMonth': startMonth != null
                                              ? int.parse(startMonth!)
                                              : null,
                                          'startYear': startYear != null
                                              ? int.parse(startYear!)
                                              : null,
                                          'minMagnitude': minMag != null
                                              ? double.parse(minMag!)
                                              : null
                                        },
                                      );
                                    }
                                  } else {
                                    Flushbars().error(context,
                                        "Provide the correct dates to fetch data");
                                  }
                                } else {
                                  Navigator.pop(context, hasValChanged);
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF1DB954)),
                                overlayColor: MaterialStateProperty.all(
                                  Colors.white30,
                                ),
                              ),
                              child: const Text(
                                "DONE",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
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
        ),
      ],
    );
  }
}

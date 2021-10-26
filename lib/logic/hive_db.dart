import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: prefer_typing_uninitialized_variables
var voyagerBox;

class HiveDB {
  hiveInit() async {
    await Hive.initFlutter();
    voyagerBox = await Hive.openBox('mainBox');
  }

  setQuake(Map data) async {
    await voyagerBox.put('quakeDb', data);
  }
}

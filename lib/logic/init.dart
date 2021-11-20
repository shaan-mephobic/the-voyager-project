import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

class Init {
  static List<Uint8List> images = [];
  cacheImages() async {
    images.add(
        (await rootBundle.load('assets/res/mars.jpg')).buffer.asUint8List());
    images.add(
        (await rootBundle.load('assets/res/stars.jpg')).buffer.asUint8List());
    images.add((await rootBundle.load('assets/res/earthquake.jpg'))
        .buffer
        .asUint8List());
  }
}

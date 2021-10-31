import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String? imageLink;

  const FullScreenImage({Key? key, @required this.imageLink}) : super(key: key);

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

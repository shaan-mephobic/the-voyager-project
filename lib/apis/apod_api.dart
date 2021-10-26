import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AstronomyPictureOfTheDay {
  // TODO For web use `flutter run -d chrome --no-sound-null-safety --web-renderer=html`
  // TODO When it isn't available show previous day's info
  fetchData(
      {@required int? year, @required int? month, @required int? day}) async {
    String _url =
        "https://apodapi.herokuapp.com/api/?date=$year-$month-$day&html_tags=true&image_thumbnail_size=1080&absolute_thumbnail_url=true";
    Map data =
        jsonDecode((await http.get(Uri.parse(Uri.encodeFull(_url)))).body);
    if (data.containsKey("error") &&
        data['error'] == "An error happened while requesting the APOD.") {
      String _url =
          "https://apodapi.herokuapp.com/api/?date=$year-$month-${day! - 1}&html_tags=true&image_thumbnail_size=1080&absolute_thumbnail_url=true";
      data = jsonDecode((await http.get(Uri.parse(Uri.encodeFull(_url)))).body);
    }
    return ApodData(
        apodSite: data['apod_site'],
        copyright: data['copyright'],
        description: data['description'],
        hdImage: data['hdurl'],
        imageThumbnail: data['image_thumbnail'],
        image: data['image'],
        mediaType: data['media_type'],
        mediaUrl: data['url'],
        title: data['title']);
  }
}

class ApodData {
  /// returns whether it is an image or a video (eg. "Image")
  final String? mediaType;

  /// returs the title of the Apod
  final String? title;

  /// returns the description of the Apod
  final String? description;

  /// return the source of the Apod (Nasa's official Apod website)
  final String? apodSite;

  /// returns the image link if the mediaType is an image
  final String? image;

  /// returns the hd image link if the mediaType is an image
  final String? hdImage;

  /// returns an image thumbnail if mediaType is video
  final String? imageThumbnail;

  /// returns the source of the media (can be video, image)
  final String? mediaUrl;

  /// returns the © Copyright information of the Apod
  final String? copyright;

  ApodData(
      {this.mediaType,
      this.title,
      this.description,
      this.apodSite,
      this.image,
      this.hdImage,
      this.imageThumbnail,
      this.mediaUrl,
      this.copyright});
}

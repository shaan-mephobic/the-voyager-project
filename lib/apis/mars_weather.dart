import 'dart:convert';

import 'package:http/http.dart' as http;

class MarsWeather {
  Future<List<MarsWeatherData>> fetchWeather() async {
    List<MarsWeatherData> marsWeather = [];
    String _url =
        "https://mars.nasa.gov/rss/api/?feed=weather&category=mars2020&feedtype=json";
    final Map data =
        jsonDecode((await http.get(Uri.parse(Uri.encodeFull(_url)))).body);
    for (int i = 0; i < data['sols'].length; i++) {
      marsWeather.add(MarsWeatherData(
        terrestrialDate: data['sols'][i]['terrestrial_date'],
        sol: data['sols'][i]['sol'],
        ls: data['sols'][i]['ls'],
        season: data['sols'][i]['season'],
        minTemp: data['sols'][i]['min_temp'].toString(),
        maxTemp: data['sols'][i]['max_temp'].toString(),
        pressure: data['sols'][i]['pressure'].toString(),
        sunrise: data['sols'][i]['sunrise'],
        sunset: data['sols'][i]['sunset'],
      ));
    }
    return marsWeather;
  }
}

class MarsWeatherData {

  /// self explainatory (eg: 2021-11-01)
  final String? terrestrialDate;

  /// solar day in mars (eg: 69)
  /// A sol is slightly longer than an Earth day
  final String? sol;

  /// The solar longitude Ls is the Mars-Sun angle
  final String? ls;

  /// self explainatory (eg: mid winter)
  final String? season;

  /// self explainatory (eg: -69.0)
  final String? minTemp;

  /// self explainatory (eg: -20.0)
  final String? maxTemp;

  /// self explainatory (eg: 650)
  final String? pressure;

  /// self explainatory (eg: 05:06:18)
  final String? sunrise;

  /// self explainatory (eg: 18:06:18)
  final String? sunset;

  MarsWeatherData(
      {this.terrestrialDate,
      this.sol,
      this.ls,
      this.season,
      this.minTemp,
      this.maxTemp,
      this.pressure,
      this.sunrise,
      this.sunset});
}

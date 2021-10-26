import 'package:http/http.dart' as http;
import 'package:the_voyager_project/logic/hive_db.dart';

class Earthquake {
  Future<List<EarthquakeData>> quakesCheck() async {
    print("check check check check");
    Map quakeDb = voyagerBox.get("quakeDb") ?? {};
    String? _url;
    if (quakeDb['startYear'] != null && quakeDb['endYear'] == null) {
      _url =
          "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=${quakeDb['startYear']}-${quakeDb['startMonth']}-${quakeDb['startDay']}&minmagnitude=${quakeDb['minMagnitude'] ?? 2}&format=text";
    } else if (quakeDb['startYear'] != null && quakeDb['endYear'] != null) {
      _url =
          "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=${quakeDb['startYear']}-${quakeDb['startMonth']}-${quakeDb['startDay']}&endtime=${quakeDb['endYear']}-${quakeDb['endMonth']}-${quakeDb['endDay']}&minmagnitude=${quakeDb['minMagnitude'] ?? 2}&format=text";
    } else {
      _url =
          "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&minmagnitude=${quakeDb['minMagnitude'] ?? 2}&format=text";
    }
    String rawData = (await http.get(Uri.parse(Uri.encodeFull(_url)))).body;
    List<String> allQuakes = rawData.split("\n");
    List<String> header = allQuakes[0].split("|");
    List earthquakes = [];
    for (int i = 1; i < allQuakes.length - 1; i++) {
      List<String> singleQuake = allQuakes[i].split("|");
      Map singleMap = {};
      for (int a = 0; a < singleQuake.length; a++) {
        singleMap[header[a]] = singleQuake[a];
      }
      if (singleMap["EventLocationName"] != null &&
          singleMap["EventLocationName"] != "") {
        earthquakes.add(singleMap);
      }
    }
    List<EarthquakeData> data = [];
    for (int i = 0; i < earthquakes.length; i++) {
      data.add(EarthquakeData(
          eventId: earthquakes[i][header[0]],
          time: earthquakes[i][header[1]],
          latitude: earthquakes[i][header[2]],
          longitude: earthquakes[i][header[3]],
          depth: earthquakes[i][header[4]],
          author: earthquakes[i][header[5]],
          catalog: earthquakes[i][header[6]],
          contributor: earthquakes[i][header[7]],
          contributorId: earthquakes[i][header[8]],
          magType: earthquakes[i][header[9]],
          magnitude: earthquakes[i][header[10]],
          magAuthor: earthquakes[i][header[11]],
          location: earthquakes[i][header[12]]));
    }
    return data;
  }
}

class EarthquakeData {
  /// returns Id of the earthquake
  final String? eventId;

  /// returns time of quake
  final String? time;

  /// returns latitude of quake
  final String? latitude;

  /// returns longitude of quake
  final String? longitude;

  /// returns depth of quake
  final String? depth;

  /// returns author
  final String? author;

  /// returns catalog
  final String? catalog;

  /// returns contributor
  final String? contributor;

  /// returns contributorID
  final String? contributorId;

  /// returns magnitude type (eg: mww)
  final String? magType;

  /// returns magnitude (eg: 6.9)
  final String? magnitude;

  /// returns magnitude author
  final String? magAuthor;

  /// returns location of quake (eg: Atlantis)
  final String? location;

  EarthquakeData(
      {this.eventId,
      this.time,
      this.latitude,
      this.longitude,
      this.depth,
      this.author,
      this.catalog,
      this.contributor,
      this.contributorId,
      this.magType,
      this.magnitude,
      this.magAuthor,
      this.location});
}

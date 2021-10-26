import 'package:http/http.dart' as http;

class Weather {
  /// This returns all the details about the weather as a WeatherData type.
  /// Current location of the user will be used to fetch weather if no location is provided.
  Future<WeatherData> fetchWeather(String? location) async {
    String _url = location == null
        ? "https://wttr.in/?format=%c\n%C\n%x\n%h\n%t\n%f\n%w\n%l\n%m\n%M\n%p\n%P\n%D\n%S\n%z\n%s\n%d\n%T\n%Z"
        : "https://wttr.in/$location?format=%c\n%C\n%x\n%h\n%t\n%f\n%w\n%l\n%m\n%M\n%p\n%P\n%D\n%S\n%z\n%s\n%d\n%T\n%Z";
    final String data = (await http.get(Uri.parse(Uri.encodeFull(_url)))).body;
    final List<String> weather = data.split("\n");
    return WeatherData(
        weather: weather[0],
        weatherCondition: weather[1],
        weatherSymbol: weather[2],
        humidity: weather[3],
        temperature: weather[4],
        temperatureFeel: weather[5],
        wind: weather[6],
        location: weather[7],
        moonPhase: weather[8],
        moonDay: weather[9],
        precipitation: weather[10],
        pressure: weather[11],
        dawn: weather[12],
        sunrise: weather[13],
        zenith: weather[14],
        sunset: weather[15],
        dusk: weather[16],
        time: weather[17],
        timezone: weather[18]);
  }

  /// Fetch an image to display all about regions weather.
  /// Current location of the user will be used to fetch weather if no location is provided.
  fetchImage(String? location) {
    return location == null
        ? "https://wttr.in/.png"
        : "https://wttr.in/$location.png";
  }
}

class WeatherData {
  /// An emoji depicting the current weather (eg: "🌦")
  final String? weather;

  /// Weather condition (eg: "Light Rain")
  final String? weatherCondition;

  /// A symbol depicting the current weather (eg: "/")
  final String? weatherSymbol;

  /// Humidity in percentage (eg: "94%")
  final String? humidity;

  /// Actual temperature (eg: "+24°C")
  final String? temperature;

  /// Temperature feels like (eg: "+27°C")
  final String? temperatureFeel;

  /// Wind speed in km/h (eg: "→9km/h")
  final String? wind;

  /// Location of user (eg: "Los Angeles, California")
  final String? location;

  /// Moon phase in emoji (eg: "🌔")
  final String? moonPhase;

  /// Moon day (eg: "10")
  final String? moonDay;

  /// Precipitation (mm/3 hours) (eg: "7.8mm")
  final String? precipitation;

  /// Pressure (hPa) (eg: "1008hPa")
  final String? pressure;

  /// Time of dawn (eg: "06:49:46")
  final String? dawn;

  /// Time of sunrise (eg: "07:11:27")
  final String? sunrise;

  /// Time of zenith (eg: "1:07:44")
  final String? zenith;

  /// Time of sunset (eg: "17:03:46")
  final String? sunset;

  /// Time of dusk (eg: "17:25:28")
  final String? dusk;

  /// Time updated (eg: "00:17:26+0530")
  final String? time;

  /// Local timezone (eg: "Fiji")
  final String? timezone;

  WeatherData({
    this.weather,
    this.weatherCondition,
    this.weatherSymbol,
    this.humidity,
    this.temperature,
    this.temperatureFeel,
    this.wind,
    this.location,
    this.moonPhase,
    this.moonDay,
    this.precipitation,
    this.pressure,
    this.dawn,
    this.sunrise,
    this.zenith,
    this.sunset,
    this.dusk,
    this.time,
    this.timezone,
  });
}

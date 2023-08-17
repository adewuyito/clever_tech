
import 'dart:convert';

WeatherModel weatherFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherToJson(WeatherModel data) => json.encode(data.toJson());



class WeatherModel {
  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  List<Datum> data;

  WeatherModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.data,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    timezone: json["timezone"],
    timezoneOffset: json["timezone_offset"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "timezone": timezone,
    "timezone_offset": timezoneOffset,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  double temp;
  double feelsLike;
  List<Weather> weather;

  Datum({
    required this.temp,
    required this.feelsLike,
    required this.weather,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    temp: json["temp"]?.toDouble(),
    feelsLike: json["feels_like"]?.toDouble(),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
  };
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

import 'package:clever_tech/services/location_weather_exceptions.dart';
import 'package:clever_tech/services/weather_service.dart';
import 'package:http/http.dart' as http;


class RemoteService {
  final String serviceLocation;

  RemoteService({required this.serviceLocation});

  Future<WeatherModel>? getResponse() async {
    var client = http.Client();
    Uri uri = Uri.parse(serviceLocation);

    var response = await client.get(uri);
    if (response.statusCode == 200){
      var json = response.body;
      return weatherFromJson(json);
    }else{
      throw LocationServiceDisabledException();
    }
  }
}


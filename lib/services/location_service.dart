import 'dart:developer' show log;
import 'package:geolocator/geolocator.dart';
import 'location_weather_exceptions.dart';

class UserLocation {


  Future<Position?> _getCurrentLocation() async {
    final locationService = UserLocation();

    try {
      bool isAllowed = await locationService.handleLocationPermission();
      if (isAllowed) {
        Position? position = await Geolocator.getLastKnownPosition(
          // desiredAccuracy: LocationAccuracy.medium,
          forceAndroidLocationManager: true,
        );
        return position;
      } else {
        throw LocationServicePermanentlyException();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<Position?> getPosition() async {
    try {
      if (await handleLocationPermission()) {
        final position = await _getCurrentLocation();
        return position;
      } else {
        log('getPosition permission model: Error');
      }
    } catch (e) {
      log('getPosition model: Error');
      log(e.toString());
    }
    return null;
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('Location is Disabled');
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          LocationServiceDeniedException();
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        LocationServicePermanentlyException();
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
    return true;
  }
}

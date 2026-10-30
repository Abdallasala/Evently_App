import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:geocoding_platform_interface/legacy/geocoding_platform_interface.dart' hide Placemark;
import 'package:geocoding_platform_interface/legacy/src/models/placemark.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getAddressFromCoordinates(double lat, double lng) async {
    if (kIsWeb) {
      return "Cairo, Egypt";
    }
    try {
      final platform = GeocodingPlatform.instance;
      if (platform != null) {
        List<Placemark> placemarks =
            await platform.placemarkFromCoordinates(lat, lng);
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          final city = place.locality ?? place.subAdministrativeArea ?? place.administrativeArea ?? '';
          final country = place.country ?? '';
          if (city.isNotEmpty && country.isNotEmpty) {
            return "$city, $country";
          } else if (city.isNotEmpty) {
            return city;
          } else if (country.isNotEmpty) {
            return country;
          }
        }
      }
    } catch (e) {
      log("Geocoding error: $e");
    }
    return "Cairo, Egypt";
  }

  static Future<String> getCurrentCityAndCountry() async {
    if (kIsWeb) {
      return "Cairo, Egypt";
    }
    try {
      final position = await getCurrentLocation();
      return await getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      log("Location error: $e");
      return "Cairo, Egypt";
    }
  }
}


import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationServices {
static  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.denied||permission == LocationPermission.denied) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
    //  var result = await Geolocator.openLocationSettings();
      var result = await Permission.location.request();
      return Future.error('Location services are disabled.');
    }


    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var location =  await Geolocator.getCurrentPosition();
    final Geocoding geocoding = Geocoding();
    List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(location.latitude, location.longitude);
    print( "Street : ${placemarks[0].street}");
    print( "Locality : ${placemarks[0].locality}");
    print( "Country : ${placemarks[0].country}");
    print( "subLocality : ${placemarks[0].subLocality}");
    print( "Street : ${placemarks[0].street}");
    print(location.toString());
    return  location;
  }
}
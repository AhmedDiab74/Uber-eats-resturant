import 'dart:math';

import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ubereatsresturant/constant/constant.dart';

class LocationServices {
  static getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        getCurrentLocation();
      }
    }
    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    print(currentPosition.toString());
    return currentPosition;
  }

  static registerResturantLocationInGeofire() async {
    Position currentLocation = await getCurrentLocation();
    Geofire.initialize(geofirePath);
    Geofire.setLocation(auth.currentUser!.uid, currentLocation.latitude,
        currentLocation.longitude);
        
  }
}

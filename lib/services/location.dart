import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double latitude=0;
  double longitude=0;
  Future <void> getCurrentLocation() async{
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude=position.latitude;
      longitude=position.longitude;
      print(latitude);
      print(longitude);
    }
    catch (e) {
      print(e);
    }
  }
}

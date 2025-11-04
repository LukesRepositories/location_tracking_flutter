import 'package:flutter/material.dart';
import 'package:location_tracking_flutter/pages/geolocatorPackage.dart';
import 'package:location_tracking_flutter/pages/home.dart';
import 'package:location_tracking_flutter/pages/primeNumberPage.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/geolocatorPackage': (context) => GeolocatorPackage(),
      '/primeNumberPage': (context) => PrimeNumberPage(),
    },
  ));
}

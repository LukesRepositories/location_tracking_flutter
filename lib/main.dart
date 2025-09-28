import 'package:flutter/material.dart';
import 'package:location_tracking_flutter/pages/home.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
    },
  ));
}

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/locationPackage');
              },
              child: const Text("Location Package"),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/geolocatorPackage');
              },
              child: const Text("Geolocator Package"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class LocationPackage extends StatefulWidget {
  const LocationPackage({super.key});

  @override
  State<LocationPackage> createState() => _HomeState();
}

class _HomeState extends State<LocationPackage> {

  String _primeNumber = "";
  String _timeTaken = "";

  bool isPrime(int n) {
    if(n<2) {
      return false;
    }
    for(int i = 2; i < n; i++) {
      if(n % i == 0){
        return false;
      }
    }
    return true;
  }

  void getHighestPrime(int limit) {
    final stopwatch = Stopwatch()..start();
    int highestPrime = 2;
    int n = limit;
    for(int i = 2; i < n; i++) {
      if(isPrime(i)) {
        highestPrime = i;
      }
    }
    stopwatch.stop();
    setState(() {
      _primeNumber = highestPrime.toString();
      _timeTaken = stopwatch.elapsed.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LocationPackage Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                getHighestPrime(250000);
              },
              child: const Text("Get prime number"),
            ),
            Text(
              _primeNumber,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              _timeTaken,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

/*
import 'package:location/location.dart';

class LocationPackage extends StatefulWidget {
  const LocationPackage({super.key});

  @override
  State<LocationPackage> createState() => _LocationPackageState();
}

class _LocationPackageState extends State<LocationPackage> {

  final Location _location = Location();
  String _locationMessage = "Press the button to get location";

  Future<void> _getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location service is enabled
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        setState(() {
          _locationMessage = "Location services are disabled.";
        });
        return;
      }
    }

    // Check for permissions
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          _locationMessage = "Location permission denied.";
        });
        return;
      }
    }

    final stopwatch = Stopwatch()..start();
    // Get the actual location
    final position = await _location.getLocation();
    stopwatch.stop();

    setState(() {
      _locationMessage =
      "Latitude: ${position.latitude}\nLongitude: ${position.longitude}\nAccuracy: ${position.accuracy}\nAltitude: ${position.altitude}\nSpeed: ${position.speed}\nHeading: ${position.heading}\nTime-taken: ${stopwatch.elapsed}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Package")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_locationMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getLocation,
              child: const Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
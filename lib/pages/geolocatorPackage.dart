import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorPackage extends StatefulWidget {
  const GeolocatorPackage({super.key});

  @override
  State<GeolocatorPackage> createState() => _LocationPageState();
}

class _LocationPageState extends State<GeolocatorPackage> {
  String _locationMessage = "";

  // Default accuracy
  LocationAccuracy _selectedAccuracy = LocationAccuracy.high;

  // Dropdown items for LocationAccuracy
  final Map<LocationAccuracy, String> _accuracyOptions = {
    LocationAccuracy.lowest: "Lowest",
    LocationAccuracy.low: "Low",
    LocationAccuracy.medium: "Medium",
    LocationAccuracy.high: "High",
    LocationAccuracy.best: "Best",
    LocationAccuracy.bestForNavigation: "Best for Navigation",
  };

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Location services are disabled.";
      });
      return;
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Location permission denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
        "Location permissions are permanently denied. Please enable them in settings.";
      });
      return;
    }

    final stopwatch = Stopwatch()..start();
    // Get the current position
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: _selectedAccuracy,
    );
    stopwatch.stop();

    setState(() {
      _locationMessage =
      "Latitude: ${position.latitude}\nLongitude: ${position.longitude}\nTime-taken: ${stopwatch.elapsed}\nAccuracy: ${position.accuracy}\nAltitude: ${position.altitude}\nSpeed: ${position.speed}\nHeading: ${position.heading}\nTime-taken: ${stopwatch.elapsed}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geolocator Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Press the button to get location",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getLocation,
              child: const Text("Get Location"),
            ),
            // Dropdown menu for accuracy
            DropdownButton<LocationAccuracy>(
              value: _selectedAccuracy,
              items: _accuracyOptions.entries
                  .map(
                    (entry) => DropdownMenuItem<LocationAccuracy>(
                  value: entry.key,
                  child: Text(entry.value),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedAccuracy = value;
                  });
                }
              },
            ),
            if(_locationMessage.isNotEmpty)
              Text(
              _locationMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

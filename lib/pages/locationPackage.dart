import 'package:flutter/material.dart';
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

    // Get the actual location
    final locationData = await _location.getLocation();

    setState(() {
      _locationMessage =
      "Lat: ${locationData.latitude}, Long: ${locationData.longitude}";
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

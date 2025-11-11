import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class RestGetPage extends StatefulWidget {
  const RestGetPage({super.key});

  @override
  State<RestGetPage> createState() => _RestGetPageState();
}

class _RestGetPageState extends State<RestGetPage> {

  String _foo1 = "";
  String _timeTaken = "";


  Future<void> getData() async {

    final stopwatch = Stopwatch()..start();
    Response response = await get(Uri.parse('https://timeapi.io/api/TimeZone/zone?timeZone=Europe/London'));
    stopwatch.stop();

    Map data = jsonDecode(response.body) as Map;

    setState(() {
      _foo1 = data['currentLocalTime'];
      _timeTaken = stopwatch.elapsed.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("REST GET Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(30.0),
              child: Text(
                "Sends a REST GET to https://timeapi.io/api/TimeZone/zone?timeZone=Europe/London",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                getData();
              },
              child: const Text("Get lorem ipsum"),
            ),
            Text(
              "returned GET: $_foo1",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Time taken: $_timeTaken",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const platform = MethodChannel('battery');
  static const alarm = MethodChannel('alarm');

  int _batteryLevel = 0;
  bool _warningEnabled = false;
  int _brightnessLevel = 50;
  double _volumeLevel = 0.5;

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  Future<void> _getBatteryLevel() async {
    int batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = result;
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to get battery level: '${e.message}'.");
      batteryLevel = -999;
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });

    if (_batteryLevel < 10 && _warningEnabled) {
      _playAlarm();
    }
  }

  Future<void> _playAlarm() async {
    try {
      final String result = await alarm.invokeMethod('playAlarm');
      // ignore: avoid_print
      print(result);
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Failed to play alarm: '${e.message}'.");
    }
  }

  void _toggleWarning(bool value) {
    setState(() {
      _warningEnabled = value;
    });
  }

  void _setBrightness(double value) {
    setState(() {
      _brightnessLevel = (value * 100).round();
    });
    //SystemChrome.setBrightness(value);
  }

  void _setVolume(double value) {
    setState(() {
      _volumeLevel = value;
    });
    // TODO: Set the device volume using a plugin or platform-specific code
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue, // Set the AppBar background color to blue
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white, // Set the page background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '-Battery-',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Switch(
              value: _warningEnabled,
              onChanged: _toggleWarning,
            ),
            const SizedBox(height: 100.0),
            const Text(
              '-Brightness-',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _brightnessLevel / 100,
              onChanged: _setBrightness,
            ),
            const SizedBox(height: 10.0),
            const Text(
              '-Volume-',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _volumeLevel,
              onChanged: _setVolume,
            ),
          ],
        ),
      ),
    );
  }
}

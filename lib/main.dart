import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'pages/create_account.dart';
import 'pages/assistance.dart';
import 'pages/emergency.dart';
import 'pages/messaging.dart';
import 'pages/calendar.dart';
import 'pages/settings.dart';
import 'pages/camera.dart';
// ignore: unused_import
import 'pages/logout.dart';
import 'pages/login.dart';
import 'pages/food.dart';
import 'pages/map.dart';

Future<void> main() async {
  // await Firebase.initializeApp();
  runApp(const Eldie());
}

class Eldie extends StatelessWidget {
  const Eldie({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginPage(),
        '/createaccount': (context) => const CreateAccountPage(),
        '/food': (context) => const MealOrderPage(),
        '/assistance': (context) => const AssistancePage(),
        '/messaging': (context) => const MessagingPage(),
        '/calendar': (context) => const CalendarPage(),
        '/emergency': (context) => const EmergencyPage(),
        '/camera': (context) => const CameraGalleryPage(),
        '/settings': (context) => const SettingsPage(),
        // '/logout': (context) => const LogoutPage(),
        '/map': (context) => const MapPage(),
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eldie'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildAppBarButton(Icons.settings, () {
                Navigator.pushNamed(context, '/settings');
              }),
              _buildAppBarButton(Icons.login, () {
                Navigator.pushNamed(context, '/login');
              }),
              _buildAppBarButton(Icons.logout, () {
                // Navigator.pushNamed(context, '/logout');
              }),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildButton(Icons.map, 'Map', () {
                Navigator.pushNamed(context, '/map');
              }),
            ]),
            const SizedBox(height: 5.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildButton(Icons.fastfood, 'Food', () {
                Navigator.pushNamed(context, '/food');
              }),
            ]),
            const SizedBox(height: 5.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildButton(Icons.assistant, 'Assistance', () {
                Navigator.pushNamed(context, '/assistance');
              }),
            ]),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/emergency');
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(65.0),
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Emergency',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildButton(Icons.message, 'Messaging', () {
                Navigator.pushNamed(context, '/messaging');
              }),
            ]),
            const SizedBox(height: 5.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildButton(Icons.calendar_today, 'Calendar', () {
                Navigator.pushNamed(context, '/calendar');
              }),
            ]),
            const SizedBox(height: 5.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildButton(Icons.camera_alt, 'Camera', () {
                Navigator.pushNamed(context, '/camera');
              }),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }

  Widget _buildAppBarButton(IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: const Text(""),
    );
  }
}

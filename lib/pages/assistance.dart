import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AssistancePage extends StatefulWidget {
  const AssistancePage({Key? key}) : super(key: key);

  @override
  _AssistancePageState createState() => _AssistancePageState();
}

class _AssistancePageState extends State<AssistancePage> {
  final _emailAddress = 'example@example.com';
  final _additionalDetailsController = TextEditingController();

  Future<void> _sendEmail(String subject, String body) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: _emailAddress,
      query: 'subject=$subject&body=$body',
    );
    final url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    _additionalDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('What type of assistance do you need?'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () =>
                  _sendEmail('Eating Assistance', 'I need help with eating.'),
              child: const Text('Eating Assistance'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _sendEmail(
                  'Medical Assistance', 'I need help with my medicine.'),
              child: const Text('Medical Assistance'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _sendEmail(
                  'Restroom Assistance', 'I need help with the restroom.'),
              child: const Text('Restroom Assistance'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _additionalDetailsController,
              decoration: const InputDecoration(
                labelText: 'Additional Details (Optional)',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final additionalDetails =
                    _additionalDetailsController.text.trim();
                final body =
                    'Additional Details: ${additionalDetails.isNotEmpty ? additionalDetails : 'N/A'}';
                _sendEmail('Assistance Request', body);
              },
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}

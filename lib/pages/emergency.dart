import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  String? _selectedContact;
  final List<String> _emergencyContacts = [
    '911',
    '999',
    '112',
    'National Poison Control Center: +1-800-222-1222',
    'Emergency Medical Services: +1-800-634-7856',
  ];

  final TextEditingController _contactController = TextEditingController();

  void _callSelectedContact() async {
    String phoneNumber =
        // ignore: unnecessary_new
        _selectedContact!.replaceAll(new RegExp(r'[^\d+]'), '');
    final Uri params = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    String url = params.toString();
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _addContact() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Emergency Contact'),
          content: TextField(
            controller: _contactController,
            decoration: const InputDecoration(
              hintText: 'Enter contact information',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _emergencyContacts.add(_contactController.text);
                  _selectedContact = _contactController.text;
                });
                _contactController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                _contactController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 165.0),
            const Text('Select an emergency contact:'),
            const SizedBox(height: 8.0),
            DropdownButton<String?>(
              value: _selectedContact,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedContact = newValue;
                });
              },
              items: _emergencyContacts.map((String contact) {
                return DropdownMenuItem<String?>(
                  value: contact,
                  child: Text(contact),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _callSelectedContact,
              child: const Text('Call selected contact'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addContact,
              child: const Text('Add custom emergency contact'),
            ),
          ],
        ),
      ),
    );
  }
}

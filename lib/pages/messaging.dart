import 'package:flutter/material.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MessagingPageState createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _friendsList = [
    "John",
    "Sarah",
    "Mark",
    "Emma",
    "David",
    "Lucy",
    "Alex",
    "Amanda",
    "Tom"
  ];

  String _currentFriend = "";

  void _sendMessage() {
    
    print("Message sent!");
    _textEditingController.clear();
  }

  void _selectFriend(String friend) {
    setState(() {
      _currentFriend = friend;
    });
  }

  void _addNewContact() {
    print("New contact added!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messaging"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: ListView.builder(
                itemCount: _friendsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_friendsList[index]),
                    onTap: () {
                      _selectFriend(_friendsList[index]);
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey[100],
                    child: Center(
                      child: _currentFriend == ""
                          ? const Text("Select a friend to start chatting!")
                          : Text("Chatting with $_currentFriend"),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: _textEditingController,
                          decoration: const InputDecoration(
                            hintText: "Type your message...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewContact,
        child: const Icon(Icons.add),
      ),
    );
  }
}

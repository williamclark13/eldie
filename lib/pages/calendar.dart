import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _titleController = TextEditingController();
  bool _isDaily = false;
  bool _hasReminder = false;
  final List<String> _reminderTypes = ['One-time', 'Daily'];
  String _reminderType = 'One-time';
  TimeOfDay? _selectedTime;
  final List<Task> _tasks = [];

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _createTask() {
    final title = _titleController.text;
    final task = Task(
      title: title,
      date: _selectedDate,
      time: _selectedTime,
      isDaily: _isDaily,
      hasReminder: _hasReminder,
      reminderType: _reminderType,
    );

    setState(() {
      _tasks.add(task);
      _titleController.clear(); // Reset title field
      _selectedDate = DateTime.now(); // Reset date to today
      _selectedTime = null; // Reset time
      _isDaily = false; // Reset daily task checkbox
      _hasReminder = false; // Reset reminder checkbox
      _reminderType = 'One-time';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Set vertical alignment to center
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text("Date: "),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      DateFormat('MMM dd, yyyy').format(_selectedDate),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text("Time: "),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: _selectedTime == null
                        ? const Text(
                            "Select Time",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            _selectedTime!.format(context),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text("Reminder Type: "),
                  DropdownButton(
                    value: _reminderType,
                    onChanged: (value) {
                      setState(() {
                        _reminderType = value as String;
                      });
                    },
                    items: _reminderTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _createTask,
                child: const Text("Create Task"),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tasks[index].title),
                    subtitle: Text(
                        "${DateFormat('MMM dd, yyyy').format(_tasks[index].date)} at ${_tasks[index].time == null ? 'No time selected' : _tasks[index].time!.format(context)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _tasks.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  final String title;
  final DateTime date;
  final TimeOfDay? time;
  final bool isDaily;
  final bool hasReminder;
  final String reminderType;

  Task({
    required this.title,
    required this.date,
    required this.time,
    required this.isDaily,
    required this.hasReminder,
    required this.reminderType,
  });
}

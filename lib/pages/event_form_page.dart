import 'package:flutter/material.dart';

class EventForm extends StatelessWidget {
  const EventForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Form"),
      ),
      body: Center(
        child: Text('This is the event form page'),
      ),
    );
  }
}

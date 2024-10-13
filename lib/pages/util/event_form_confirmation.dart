import 'package:flutter/material.dart';

class EventFormConfirmation extends StatelessWidget {
  final String image;
  final String eventName;
  final String eventTime;
  final String location;
  final String sport;
  final String skillLevel;
  final int curr_avail;
  final int max_avail;

  const EventFormConfirmation({
    Key? key,
    required this.image,
    required this.eventName,
    required this.eventTime,
    required this.location,
    required this.sport,
    required this.skillLevel,
    required this.curr_avail,
    required this.max_avail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Form Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: image.startsWith('http') || image.startsWith('https')
                  ? Image.network(image, height: 200, fit: BoxFit.cover)
                  : Image.asset(image, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Text(
              eventName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Time: $eventTime',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Location: $location',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Sport: $sport',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Skill Level: $skillLevel',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Availability: $curr_avail/$max_avail',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add confirmation logic here
                },
                child: Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
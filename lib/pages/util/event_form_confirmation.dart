import 'package:flutter/material.dart';

class EventFormConfirmation extends StatefulWidget {
  final String image;
  final String eventName;
  final String eventTime;
  final String location;
  final String sport;
  final String skillLevel;
  final int curr_avail;
  final int max_avail;
  final bool spotConfirmed;

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
    this.spotConfirmed = false,
  }) : super(key: key);

  @override
  _EventFormConfirmationState createState() => _EventFormConfirmationState();
}

class _EventFormConfirmationState extends State<EventFormConfirmation> {
  late int _currentAvailability;
  late bool _spotConfirmed;

  @override
  void initState() {
    super.initState();
    _currentAvailability = widget.curr_avail;
    _spotConfirmed = widget.spotConfirmed;
  }

  void _incrementAvailability() {
    if (!_spotConfirmed && _currentAvailability < widget.max_avail) {
      setState(() {
        _currentAvailability++;
        _spotConfirmed = true;
      });
    }
  }

  void _confirmSpot() {
    _incrementAvailability();
    Navigator.pop(context, {'currentAvailability': _currentAvailability, 'spotConfirmed': _spotConfirmed});
  }

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
              child: widget.image.startsWith('http') || widget.image.startsWith('https')
                  ? Image.network(widget.image, height: 200, fit: BoxFit.cover)
                  : Image.asset(widget.image, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Text(
              widget.eventName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Time: ${widget.eventTime}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Location: ${widget.location}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Sport: ${widget.sport}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Skill Level: ${widget.skillLevel}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Availability: $_currentAvailability/${widget.max_avail}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _spotConfirmed ? null : _confirmSpot,
                child: Text(_spotConfirmed ? 'Spot Confirmed' : 'Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
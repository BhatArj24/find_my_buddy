import 'package:flutter/material.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  _EventCreationPageState createState() => _EventCreationPageState();
}

class _EventCreationPageState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  String _eventName = '';
  int _desiredBuddies = 0;
  DateTime _eventDate = DateTime.now();
  TimeOfDay _eventTime = TimeOfDay.now();
  String _formattedTime = '';
  String _formattedDate = '';
  String _selectedSport = '';
  String _selectedLocation = '';

  final List<String> _sports = [
    'Soccer',
    'Basketball',
    'Tennis',
    'Baseball',
    'Volleyball',
    'Badminton',
    'Football',
    'Ultimate Frisbee',
    'Spikeball',
    'Squash',
    'Racquetball',
  ];
  final List<String> _locations = [
    'IMA Badminton Gym',
    'Denny Field',
    'North Campus Basketball Courts',
    'IMA Tennis Courts',
    'IMA Sand Volleybal Courts',
    'IMA Turf Field',
    'IMA Squash/Racquetball Courts'
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _formattedTime = _formatTimeOfDay(_eventTime);
    _formattedDate = _formatEventDate(_eventDate);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final format = MaterialLocalizations.of(context).formatTimeOfDay(time);
    return format;
  }

  String _formatEventDate(DateTime date) {
    final format = MaterialLocalizations.of(context).formatFullDate(date);
    return format;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _eventName = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: '# of Buddies Desired'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null ||
                      int.parse(value) <= 0) {
                    return 'Please enter a positive desired # of Buddies';
                  }
                  return null;
                },
                onSaved: (value) {
                  _desiredBuddies = int.parse(value!);
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Event Date'),
                readOnly: true,
                controller: TextEditingController(text: _formattedDate),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _eventDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _eventDate) {
                    setState(() {
                      _eventDate = pickedDate;
                      _formattedDate = _formatEventDate(pickedDate);
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Event Time'),
                readOnly: true,
                controller: TextEditingController(text: _formattedTime),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _eventTime,
                  );
                  if (pickedTime != null && pickedTime != _eventTime) {
                    setState(() {
                      _eventTime = pickedTime;
                      _formattedTime = _formatTimeOfDay(pickedTime);
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select Sport'),
                value: _selectedSport.isEmpty ? null : _selectedSport,
                items: _sports.map((String sport) {
                  return DropdownMenuItem<String>(
                    value: sport,
                    child: Text(sport),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedSport = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a sport';
                  }
                  return null;
                },
                onSaved: (value) {
                  _selectedSport = value!;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select Location'),
                value: _selectedLocation.isEmpty ? null : _selectedLocation,
                items: _locations.map((String location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a location';
                  }
                  return null;
                },
                onSaved: (value) {
                  _selectedLocation = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // send to backend
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: const Text('Create Event',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

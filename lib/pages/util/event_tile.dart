import 'package:find_my_buddy/pages/util/event_form_confirmation.dart';
import 'package:flutter/material.dart';

class EventTile extends StatefulWidget {
  final String image;
  final String eventName;
  final String eventTime;
  final String location;
  final String sport;
  final String skillLevel;
  final int curr_avail;
  final int max_avail;

  const EventTile({
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
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  late int _currentAvailability;
  bool _spotConfirmed = false; // Track if the spot has been confirmed

  @override
  void initState() {
    super.initState();
    _currentAvailability = widget.curr_avail; // Initialize with current availability
  }

  void _incrementAvailability() {
    setState(() {
      _currentAvailability++; // Increment current availability by 1
      _spotConfirmed = true; // Mark the spot as confirmed
    });
  }

  void _showAlreadyConfirmedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You have already confirmed your spot.'),
      ),
    );
  }

  void _showMaxAvailabilityMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Maximum availability reached.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.image,
                  height: 90,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                child: Text(
                  'Location: ' + widget.location,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.eventName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                widget.eventTime,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      widget.sport,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      widget.skillLevel,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    'Availability: ' +
                        _currentAvailability.toString() +
                        '/' +
                        widget.max_avail.toString(),
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () async {
                      if (_spotConfirmed) {
                        _showAlreadyConfirmedMessage();
                        return;
                      }
                      if (_currentAvailability >= widget.max_avail) {
                        _showMaxAvailabilityMessage();
                        return;
                      }
                      final newAvailability = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventFormConfirmation(
                            image: widget.image,
                            eventName: widget.eventName,
                            eventTime: widget.eventTime,
                            location: widget.location,
                            sport: widget.sport,
                            skillLevel: widget.skillLevel,
                            curr_avail: _currentAvailability,
                            max_avail: widget.max_avail,
                          ),
                        ),
                      );

                      if (newAvailability != null) {
                        // Only increment if the confirmation returns a value
                        _incrementAvailability();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.green,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

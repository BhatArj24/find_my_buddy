// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:find_my_buddy/pages/util/event_form_confirmation.dart';
import 'package:flutter/material.dart';


class EventTile extends StatelessWidget {
  final image;
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          )),
      child: Row(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
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
                  'Location: ' + location,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                eventTime,
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
                      sport,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
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
                      skillLevel,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    'Availability: ' +
                        curr_avail.toString() +
                        '/' +
                        max_avail.toString(),
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventFormConfirmation(
                          image: image,
                          eventName: eventName,
                          eventTime: eventTime,
                          location: location,
                          sport: sport,
                          skillLevel: skillLevel,
                          curr_avail: curr_avail,
                          max_avail: max_avail,
                        ),
                      ),
                    );
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
              )
            ],
          ),
        ],
      ),
    );
  }
}

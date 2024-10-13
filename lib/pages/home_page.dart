// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:find_my_buddy/pages/util/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart'; // Import Amplify
import 'event_form_page.dart'; // Import the event form page
import 'user_profile_page.dart' as custom_profile; // Use an alias for the user profile import

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _username = 'Guest'; // Default username

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser(); // Fetch the current user on init
  }

  Future<void> _fetchCurrentUser() async {
    try {
      // Fetch the current user's attributes
      final userAttributes = await Amplify.Auth.fetchUserAttributes();
      final usernameAttribute = userAttributes
          .firstWhere((attr) => attr.userAttributeKey.key == 'name');

      // Update the state with the fetched username
      setState(() {
        _username = usernameAttribute.value;
      });
    } catch (e) {
      print('Error fetching user attributes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 1:
              // Navigate to the EventFormPage when the event icon is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventForm()),
              );
              break;
            case 2:
              // Navigate to the custom_profile.UserProfilePage when the person icon is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => custom_profile.UserProfile()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: '',
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            // Profile image
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/user_headshot.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _username, // Display the dynamic username
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}', // Display the current date
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Search bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for events',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(Icons.search,
                          color: Theme.of(context).colorScheme.primary),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2.0)),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    ),
                  ),
                  // Display all the event tiles
                  SizedBox(height: 20),
                  EventTile(
                    image: 'assets/images/ima_building.jpg',
                    eventName: "Pickleball",
                    eventTime: "10:00 AM - 11:00 AM",
                    location: "IMA Building",
                    sport: "Pickleball",
                    skillLevel: "amateur",
                    curr_avail: 2,
                    max_avail: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

  bool _filterLocation = false;
  bool _filterSport = false;
  bool _filterSkill = false;
  bool _sortByTime = false; // Add this line
  bool _sortBySkill = false; // Add this line

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

  void _showFilterDropdown(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, 0), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset(0, button.size.height)), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: Container(
            width: button.size.width,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text('Location'),
                        value: _filterLocation,
                        onChanged: (bool? value) {
                          setState(() {
                            _filterLocation = value!;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text('Sport'),
                        value: _filterSport,
                        onChanged: (bool? value) {
                          setState(() {
                            _filterSport = value!;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        title: Text('Skill'),
                        value: _filterSkill,
                        onChanged: (bool? value) {
                          setState(() {
                            _filterSkill = value!;
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

void _showSortDropdown(BuildContext context) {
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      button.localToGlobal(Offset(button.size.width, 0), ancestor: overlay), // Horizontal offset for right alignment
      button.localToGlobal(button.size.bottomRight(Offset(button.size.width + 150, button.size.height)), ancestor: overlay), // Adjust width as needed
    ),
    Offset.zero & overlay.size,
  );

  showMenu(
    context: context,
    position: position,
    items: [
      PopupMenuItem(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CheckboxListTile(
              title: Text('Sort by Time'),
              value: _sortByTime,
              onChanged: (bool? value) {
                setState(() {
                  _sortByTime = value!;
                });
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      PopupMenuItem(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CheckboxListTile(
              title: Text('Sort by Skill'),
              value: _sortBySkill,
              onChanged: (bool? value) {
                setState(() {
                  _sortBySkill = value!;
                });
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    ],
    elevation: 8.0,
  );
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
                  SizedBox(height: 10),
                  // Filter and Sort buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _showFilterDropdown(context);
                        },
                        icon: Icon(Icons.filter_list),
                        label: Text('Filter'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showSortDropdown(context);
                        },
                        icon: Icon(Icons.sort),
                        label: Text('Sort'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Display all the event tiles
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
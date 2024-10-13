import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfile> {
  String? _name;
  String? _email;
  List<String> _selectedSports = [];
  final List<String> _sports = [
    'Soccer', 'Basketball', 'Baseball', 'Tennis', 'Golf', 'Running', 'Volleyball', 'Swimming', 'Boxing', 'Table Tennis',
    'Badminton', 'Rugby', 'Cricket', 'Hockey', 'Skiing', 'Snowboarding', 'Skateboarding', 'Surfing', 'Cycling', 'Wrestling'
  ];
  String? _selectedSport;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _loadSelectedSports();
  }

  Future<void> _fetchUserData() async {
    try {
      var attributes = await Amplify.Auth.fetchUserAttributes();
      var name = attributes.firstWhere((attr) => attr.userAttributeKey == AuthUserAttributeKey.name).value;
      var email = attributes.firstWhere((attr) => attr.userAttributeKey == AuthUserAttributeKey.email).value;

      setState(() {
        _name = name;
        _email = email;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _loadSelectedSports() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedSports = prefs.getStringList('selectedSports') ?? [];
    });
  }

  Future<void> _saveSelectedSports() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedSports', _selectedSports);
  }

  void _addSport(String sport) {
    setState(() {
      if (!_selectedSports.contains(sport)) {
        _selectedSports.add(sport);
      }
    });
  }

  void _removeSport(String sport) {
    setState(() {
      _selectedSports.remove(sport);
    });
  }

  void _saveSports() {
    _saveSelectedSports();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sports saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: _name == null || _email == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.purple[50],
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Text(
                        _name!,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _email!,
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Select Sports',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      DropdownButton<String>(
                        value: _selectedSport,
                        hint: Text('Select a sport'),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSport = newValue;
                          });
                          if (newValue != null) {
                            _addSport(newValue);
                          }
                        },
                        items: _sports.map<DropdownMenuItem<String>>((String sport) {
                          return DropdownMenuItem<String>(
                            value: sport,
                            child: Text(sport),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: _selectedSports.map((sport) {
                          return Chip(
                            label: Text(sport),
                            backgroundColor: Colors.blue[100],
                            deleteIcon: Icon(Icons.close),
                            onDeleted: () {
                              _removeSport(sport);
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _saveSports,
                        child: Text('Save'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Logout functionality to be added later
                        },
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final List<String> _sports = ['Football', 'Basketball', 'Tennis', 'Running', 'Swimming', 'Cycling', 'Baseball', 'Soccer', 'Volleyball', 'Hockey'];
  final List<String> _experienceLevels = ['Beginner', 'Intermediate', 'Advanced'];

  List<String?> _selectedSports = [null, null, null];
  List<String?> _selectedExperienceLevels = [null, null, null];

  List<String?> _rankedSports = [null, null, null, null, null];
  List<Map<String, TimeOfDay?>> _availability = List.generate(7, (_) => {'startTime': null, 'endTime': null});

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstNameController.text = prefs.getString('firstName') ?? '';
      _lastNameController.text = prefs.getString('lastName') ?? '';
      _usernameController.text = prefs.getString('username') ?? '';
      _bioController.text = prefs.getString('bio') ?? '';
      for (int i = 0; i < 3; i++) {
        _selectedSports[i] = prefs.getString('selectedSport_$i');
        _selectedExperienceLevels[i] = prefs.getString('selectedExperienceLevel_$i');
      }
      for (int i = 0; i < 5; i++) {
        _rankedSports[i] = prefs.getString('rankedSport_$i');
      }
    });
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', _firstNameController.text);
    await prefs.setString('lastName', _lastNameController.text);
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('bio', _bioController.text);
    for (int i = 0; i < 3; i++) {
      await prefs.setString('selectedSport_$i', _selectedSports[i] ?? '');
      await prefs.setString('selectedExperienceLevel_$i', _selectedExperienceLevels[i] ?? '');
    }
    for (int i = 0; i < 5; i++) {
      await prefs.setString('rankedSport_$i', _rankedSports[i] ?? '');
    }
  }

  @override
  void dispose() {
    _saveUserData();
    super.dispose();
  }

  Future<void> _changeUsername() async {
    TextEditingController _newUsernameController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Username'),
          content: TextField(
            controller: _newUsernameController,
            decoration: InputDecoration(
              labelText: 'New Username',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  _usernameController.text = _newUsernameController.text;
                });
                await _saveUserData();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changePassword() async {
    TextEditingController _newPasswordController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: TextField(
            controller: _newPasswordController,
            decoration: InputDecoration(
              labelText: 'New Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Save the new password (this is just a placeholder, implement your own logic)
                // For example, you might want to hash the password and store it securely
                await _saveUserData();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
 @override
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("User Profile"),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _firstNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _lastNameController,
            decoration: InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _changeUsername,
                  child: Text('Change Username'),
                ),
                ElevatedButton(
                  onPressed: _changePassword,
                  child: Text('Change Password'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _bioController,
            maxLength: 150,
            maxLines: null, // Allows the text field to expand vertically
            decoration: InputDecoration(
              labelText: 'Short Bio',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue[50], // Light Blue Background
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sports and Experience Levels',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ...List.generate(3, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _selectedSports[index],
                        items: _sports.map((String sport) {
                          return DropdownMenuItem<String>(
                            value: sport,
                            child: Text(sport),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSports[index] = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Select Sport',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedExperienceLevels[index],
                        items: _experienceLevels.map((String level) {
                          return DropdownMenuItem<String>(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedExperienceLevels[index] = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Experience Level',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green[50], // Light Green Background
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rank Your Favorite Sports',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ...List.generate(5, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _rankedSports[index],
                        items: _sports.map((String sport) {
                          return DropdownMenuItem<String>(
                            value: sport,
                            child: Text(sport),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _rankedSports[index] = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Select Sport for Rank ${index + 1}',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.orange[50], // Light Orange Background
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Your Availability',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ...List.generate(7, (index) {
                  String day = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][index];
                  TimeOfDay? startTime = _availability[index]['startTime'];
                  TimeOfDay? endTime = _availability[index]['endTime'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: startTime ?? TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _availability[index]['startTime'] = picked;
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: startTime != null ? startTime.format(context) : 'Start Time',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: endTime ?? TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _availability[index]['endTime'] = picked;
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: endTime != null ? endTime.format(context) : 'End Time',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_validateSelections()) {
                  _saveUserData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User data saved!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please ensure all selections are unique and not empty.')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    ),
  );
}
bool _validateSelections() {
  // Check for duplicate or empty selections in sports and experience levels
  Set<String> selectedSportsSet = _selectedSports.where((sport) => sport != null && sport!.isNotEmpty).map((sport) => sport!).toSet();
  Set<String> rankedSportsSet = _rankedSports.where((sport) => sport != null && sport!.isNotEmpty).map((sport) => sport!).toSet();

  if (selectedSportsSet.length != _selectedSports.where((sport) => sport != null && sport!.isNotEmpty).length ||
      rankedSportsSet.length != _rankedSports.where((sport) => sport != null && sport!.isNotEmpty).length) {
    return false;
  }

  // Check for empty experience levels
  for (String? experienceLevel in _selectedExperienceLevels) {
    if (experienceLevel == null || experienceLevel.isEmpty) {
      return false;
    }
  }

  return true;
}
}
import 'package:flutter/material.dart';

class UserSelect extends StatefulWidget {
  @override
  _UserSelect createState() => _UserSelect();
}

class _UserSelect extends State<UserSelect> {
  String? _selectedUser;
  List<String> _users = ["user 1", "user 2", "user 3"];

  void _showNewUserdialog() {
    showDialog(context: context, builder: (BuildContext context) {
      String newUser = '';
      return AlertDialog(
        title: Text("Neuer Benutzer"),
        content: TextField(
          onChanged: (value) {
            newUser = value;
          },
          decoration: InputDecoration(hintText: "Namen eingeben"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _users.add(newUser);
                _selectedUser = newUser;
              });
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Bestaetigen"),
          ),
        ],
      );
    });
  }

  void _showUserDeleteDialog() {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Benutzer loeschen"),
        content: Text(_selectedUser! + " loeschen?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _users.remove(_selectedUser);
                _selectedUser = _users.firstOrNull;
              });
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Bestaetigen"),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Benutzer:'),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedUser,
                  hint: Text("Benutzer waehlen"),
                  items: _users.map((String user) {
                    return DropdownMenuItem<String>(
                      value: user,
                      child: Text(user),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedUser = newValue;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showNewUserdialog();
              },
              child: Text('Neuer Bentuzer'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedUser != null) {
                  _showUserDeleteDialog();
                }
              },
              child: Text('Benuzter loeschen'),
            ),
          ],
        ),
      ),
    );
  }
}

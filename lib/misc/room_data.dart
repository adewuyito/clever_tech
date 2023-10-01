import 'dart:convert';

class UserRooms {}

var products = jsonDecode('''
      {
        "name": "Room Name",
        "status": true,
        "icon": "house",
        "devicesNo": 5,
        "devices": [
          {"name": "Television", "status": true},
          {"name": "light Bulbs", "status": true}
          ]
      }
    ''');

import 'package:flutter/material.dart';
//
// class Food {
//   String Name;
//   int Did; //id of user which store in firebase auth
//   DateTime Expire;
//   double Quantity;
//   String Location;
//   String Mobile;
//   String path;
//
//   Food({
//     this.Name = '',
//     this.Did = 0,
//     required this.Expire ,
//     this.Quantity = 0.0,
//     this.Location = '',
//     this.Mobile,
//     this.path = '/storage/emulated/0/Android/data/com.example.secondserving/files/jak.jpg'
//     // this image should be stored in firebase storage
//   });
// }
class Food {
  String id; // Add this line for the food ID
  String name;
  String userId; // id of user stored in Firebase auth
  DateTime expire;
  double quantity;
  String location;
  String mobile;
  String imagePath;

  Food({
    required this.id, // Include this in the constructor
    required this.name,
    required this.userId,
    required this.expire,
    required this.quantity,
    required this.location,
    required this.mobile,
    this.imagePath = '', // image path from Firebase Storage
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include ID in the map
      'name': name,
      'userId': userId,
      'expire': expire.toIso8601String(),
      'quantity': quantity,
      'location': location,
      'mobile': mobile,
      'imagePath': imagePath,
    };
  }

  static Food fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'] ?? '', // Include ID in fromMap
      name: map['name'],
      userId: map['userId'],
      expire: DateTime.parse(map['expire']),
      quantity: map['quantity'],
      location: map['location'],
      mobile: map['mobile'],
      imagePath: map['imagePath'],
    );
  }
}


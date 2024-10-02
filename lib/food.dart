import 'package:flutter/material.dart';

class Food {
  String Name;
  int Did;
  DateTime Expire;
  double Quantity;
  String Location;
  String path;

  Food({
    this.Name = '',
    this.Did = 0,
    required this.Expire ,
    this.Quantity = 0.0,
    this.Location = '',
    this.path = '/storage/emulated/0/Android/data/com.example.secondserving/files/jak.jpg'
  });
}

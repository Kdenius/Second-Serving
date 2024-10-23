import 'package:flutter/material.dart';
import 'package:secondserving/food.dart';
import 'package:secondserving/food_service.dart';
import 'package:secondserving/food_edit_screen.dart'; // Import the edit screen

class MyFoodsScreen extends StatelessWidget {
  final String userId;
  final FoodService _foodService = FoodService();

  MyFoodsScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Donated Foods'),
      ),
      body: StreamBuilder<List<Food>>(
        stream: _foodService.getFoods(), // Fetch all foods for the user
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final foods = snapshot.data?.where((food) => food.userId == userId).toList();

          if (foods == null || foods.isEmpty) {
            return Center(child: Text('No donated foods found.'));
          }

          return ListView.builder(
            itemCount: foods.length,
            itemBuilder: (context, index) {
              final food = foods[index];
              return Card(
                child: ListTile(
                  title: Text(food.name),
                  subtitle: Text('Expires on: ${food.expire.toLocal()}'),
                  onTap: () {
                    // Navigate to edit screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodEditScreen(food: food)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

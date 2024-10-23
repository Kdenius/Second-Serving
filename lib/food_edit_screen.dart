import 'package:flutter/material.dart';
import 'package:secondserving/food.dart';
import 'package:secondserving/food_service.dart';

class FoodEditScreen extends StatelessWidget {
  final Food food;
  final FoodService _foodService = FoodService();

  FoodEditScreen({required this.food});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: food.name);
    final expireController = TextEditingController(text: food.expire.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              controller: expireController,
              decoration: InputDecoration(labelText: 'Expiration Date'),
              readOnly: true, // You can use a DatePicker instead if needed
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Update the food details
                food.name = nameController.text;
                _foodService.updateFood(food).then((_) {
                  Navigator.pop(context); // Go back to My Foods screen
                });
              },
              child: Text('Save Changes'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Expire the food immediately
                food.expire = DateTime.now();
                _foodService.updateFood(food).then((_) {
                  Navigator.pop(context); // Go back to My Foods screen
                });
              },
              child: Text('Expire Now'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

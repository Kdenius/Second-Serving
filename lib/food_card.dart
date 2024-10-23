import 'dart:io';
import 'package:flutter/material.dart';
import 'package:secondserving/auth_service.dart';
import 'package:secondserving/food_request.dart';
import 'package:secondserving/food_request_service.dart';
import 'details.dart';
import 'food.dart';
import 'package:intl/intl.dart';

class FoodCard extends StatelessWidget {
  final Food item;
  final FoodRequestService _foodRequestService = FoodRequestService(); // New service instanc
  final AuthService _authService = AuthService();



  FoodCard({
    required this.item,
  });

  void _sendFoodRequest(context) {
    String requestDetails = '';
    String contactNumber = '';
    double quantity = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Send Food Request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  requestDetails = value;
                },
                decoration: InputDecoration(hintText: "Location :"),
              ),
              TextField(
                onChanged: (value) {
                  quantity = double.tryParse(value) ?? 0;
                },
                decoration: InputDecoration(hintText: "Enter quantity"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) {
                  contactNumber = value;
                },
                decoration: InputDecoration(hintText: "Enter your contact number"),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                FoodRequest foodRequest = FoodRequest(
                  id: '',
                  userId: _authService.currentUser!.uid,
                  foodId: item.id,
                  foodName: item.name,
                  requestedAt: DateTime.now(),
                  location: requestDetails, // You can collect the user's location
                  quantity: quantity,
                  contact: contactNumber,
                );

                // Use FoodRequestService to store the request
                await _foodRequestService.addFoodRequest(foodRequest);

                Navigator.of(context).pop();
              },
              child: Text('Send'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => DetailsScreen(item: item),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.file(
                  File(item.imagePath), // Updated to match the property name
                  fit: BoxFit.cover,
                  height: 110,
                  width: 165,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        'VEG', // Assuming all items are veg for now
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        'Category', // Consider passing this as a parameter to the Food class
                        style: TextStyle(color: Colors.lime, fontWeight: FontWeight.w800, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                item.name, // Updated to match the property name
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Expires: ${DateFormat('yyyy-MM-dd HH:mm').format(item.expire.toLocal())}',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        item.quantity.toString(),
                        style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'kg',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed('take_food', arguments: item);
                      _sendFoodRequest(context);
                    },
                    icon: const Icon(Icons.add_box),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                item.location, // Updated to match the property name
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

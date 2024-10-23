// import 'package:flutter/material.dart';
// import 'package:secondserving/food_service.dart';
// import 'package:secondserving/food.dart';
// import 'package:secondserving/auth_service.dart';
// class AddFoodScreen extends StatefulWidget {
//   @override
//   _AddFoodScreenState createState() => _AddFoodScreenState();
// }
//
// class _AddFoodScreenState extends State<AddFoodScreen> {
//   final FoodService _foodService = FoodService();
//   final AuthService _authService = AuthService();
//
//   final _formKey = GlobalKey<FormState>();
//   String _name = '';
//   DateTime _expire = DateTime.now();
//   double _quantity = 0.0;
//   String _location = '';
//   String _mobile = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Add Food')),
//         body: Padding(
//         padding: EdgeInsets.all(16.0),
//     child: Form(
//     key: _formKey,
//     child: Column(
//     children: [
//     TextFormField(
//     decoration: InputDecoration(labelText: 'Food Name'),
//     validator: (value) => value!.isEmpty ? 'Enter food name' : null,
//     onChanged: (value) => _name = value,
//     ),
//     TextFormField(
//     decoration: InputDecoration(labelText: 'Quantity'),
//     validator: (value) => value!.isEmpty ? 'Enter quantity' : null,
//     onChanged: (value) => _quantity = double.parse(value),
//     ),
//     TextFormField(
//     decoration: InputDecoration(labelText: 'Location'),
//     validator: (value) => value!.isEmpty ? 'Enter location' : null,
//     onChanged: (value) => _location = value,
//     ),
//     TextFormField(
//       decoration: InputDecoration(labelText: 'Mobile Number'),
//       validator: (value) => value!.isEmpty ? 'Enter mobile number' : null,
//       onChanged: (value) => _mobile = value,
//     ),
//       ElevatedButton(
//         onPressed: () async {
//           if (_formKey.currentState!.validate()) {
//             // Get the current user ID
//             int userId = _authService.currentUser!.uid.hashCode; // Simple hash for example
//
//             // Create a Food object
//             Food food = Food(
//               name: _name,
//               userId: userId,
//               expire: _expire,
//               quantity: _quantity,
//               location: _location,
//               mobile: _mobile,
//             );
//
//             // Add food to Firestore
//             await _foodService.addFood(food);
//             Navigator.pop(context); // Go back to Home Screen
//           }
//         },
//         child: Text('Add Food'),
//       ),
//     ],
//     ),
//     ),
//         ),
//     );
//   }
// }
//

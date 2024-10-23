// import 'dart:async'; // Import for StreamController
// import 'package:flutter/material.dart';
// import 'package:secondserving/add_food.dart';
// import 'package:secondserving/auth_service.dart';
// import 'package:secondserving/food.dart';
// import 'package:secondserving/food_card.dart';
// import 'package:secondserving/food_request.dart';
// import 'package:secondserving/food_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'food_request_service.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final FoodService _foodService = FoodService();
//   final FoodRequestService _foodRequestService = FoodRequestService(); // New service instance
//   final AuthService _authService = AuthService();
//   late StreamController<List<Food>> _foodController;
//
//   @override
//   void initState() {
//     super.initState();
//     _foodController = StreamController<List<Food>>();
//     _fetchFoods(); // Initial fetch
//   }
//
//   @override
//   void dispose() {
//     _foodController.close(); // Close the controller to avoid memory leaks
//     super.dispose();
//   }
//
//   void _fetchFoods() async {
//     final foods = await _foodService.getFoods().first; // Get the initial data
//     _foodController.add(foods); // Add to stream
//   }
//
//   void _navigateToAddFood(BuildContext context) async {
//     final newItem = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddFood()));
//     if (newItem != null) {
//       await _foodService.addFood(newItem);
//       _fetchFoods(); // Refresh the list
//     }
//   }
//
//   Future<void> _handleRefresh() async {
//     // Refresh the food list
//     await Future.delayed(Duration(seconds: 1)); // Simulate a refresh delay
//     _fetchFoods(); // Re-fetch foods from the service
//   }
//
//
//   void _sendFoodRequest() {
//     String requestDetails = '';
//     String contactNumber = '';
//     double quantity = 0;
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Send Food Request'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 onChanged: (value) {
//                   requestDetails = value;
//                 },
//                 decoration: InputDecoration(hintText: "Enter food name"),
//               ),
//               TextField(
//                 onChanged: (value) {
//                   quantity = double.tryParse(value) ?? 0;
//                 },
//                 decoration: InputDecoration(hintText: "Enter quantity"),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 onChanged: (value) {
//                   contactNumber = value;
//                 },
//                 decoration: InputDecoration(hintText: "Enter your contact number"),
//                 keyboardType: TextInputType.phone,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 // Get the current user's ID
//                 String userId = "currentUserId"; // Replace with actual user ID logic
//
//                 FoodRequest foodRequest = FoodRequest(
//                   userId: userId,
//                   foodName: requestDetails,
//                   requestedAt: DateTime.now(),
//                   location: "User Location", // You can collect the user's location
//                   quantity: quantity,
//                   contact: contactNumber,
//                 );
//
//                 // Use FoodRequestService to store the request
//                 await _foodRequestService.addFoodRequest(foodRequest);
//
//                 Navigator.of(context).pop();
//               },
//               child: Text('Send'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black12,
//       appBar: AppBar(
//         backgroundColor: Colors.limeAccent,
//         title: Row(
//           children: [
//             Image.asset('assets/images/logo.png', scale: 12),
//             const SizedBox(width: 8),
//             const Text(
//               'Second Serving',
//               style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 18,
//                   fontFamily: 'cursive'),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Implement your action here
//               //this my button on click it show sent request for food to doner
//             },
//             icon: const Icon(Icons.send_and_archive),
//           ),
//
//           IconButton(
//             onPressed: () {
//               // this button show that some wants to take food option accept or decline
//             },
//             icon: const Icon(Icons.notifications_active_outlined),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: RefreshIndicator(
//           onRefresh: _handleRefresh,
//           child: StreamBuilder<List<Food>>(
//             stream: _foodController.stream,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               }
//
//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               }
//
//               if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Center(child: Text('No food available.'));
//               }
//
//               final foods = snapshot.data!;
//               final availableFoods = foods.where((food) => food.expire.isAfter(DateTime.now())).toList();
//
//               if (availableFoods.isEmpty) {
//                 return Center(child: Text('No available food items.'));
//               }
//
//               return GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 0,
//                   mainAxisSpacing: 0,
//                   childAspectRatio: 9 / 15,
//                 ),
//                 itemCount: availableFoods.length,
//                 itemBuilder: (context, index) {
//                   final food = availableFoods[index];
//                   return FoodCard(item: food);
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.dining_outlined),
//         onPressed: () => _navigateToAddFood(context),
//         backgroundColor: Colors.lime,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             Container(
//               color: Colors.green[700],
//               width: double.infinity,
//               height: 200,
//               padding: EdgeInsets.only(top: 20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(bottom: 10),
//                     height: 70,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: AssetImage('/images/india.png'), // Ensure the path is correct
//                       ),
//                     ),
//                   ),
//                   Text(
//                     "User 1",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                   Text(
//                     'email',
//                     style: TextStyle(
//                       color: Colors.grey[200],
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               title: Text('Login'),
//               onTap: () async {
//                 final sf = await SharedPreferences.getInstance();
//                 await _authService.signOut();
//                 sf.remove('email');
//                 Navigator.pushReplacementNamed(context, 'login');
//               },
//             ),
//             ListTile(
//               title: Text('Signup'),
//               onTap: () async {
//                 final sf = await SharedPreferences.getInstance();
//                 await _authService.signOut();
//                 sf.remove('email');
//                 Navigator.pushReplacementNamed(context, 'signup');
//               },
//             ),
//             ListTile(
//               title: Text('Logout'),
//               onTap: () async {
//                 final sf = await SharedPreferences.getInstance();
//                 await _authService.signOut();
//                 sf.remove('email');
//                 Navigator.pushReplacementNamed(context, 'login');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:secondserving/add_food.dart';
import 'package:secondserving/auth_service.dart';
import 'package:secondserving/food.dart';
import 'package:secondserving/food_card.dart';
import 'package:secondserving/food_service.dart';
import 'package:secondserving/food_request_service.dart';
import 'package:secondserving/food_request.dart';
import 'package:secondserving/notification_screen.dart';
import 'package:secondserving/request_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:secondserving/my_foods_screen.dart'; // Import the new screen
import 'package:secondserving/about_us_screen.dart'; // Import About Us screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FoodService _foodService = FoodService();
  final AuthService _authService = AuthService();
  late StreamController<List<Food>> _foodController;

  @override
  void initState() {
    super.initState();
    _foodController = StreamController<List<Food>>();
    _fetchFoods(); // Initial fetch
  }

  @override
  void dispose() {
    _foodController.close(); // Close the controller to avoid memory leaks
    super.dispose();
  }

  void _fetchFoods() async {
    final foods = await _foodService.getFoods().first; // Get the initial data
    _foodController.add(foods); // Add to stream
  }

  void _navigateToAddFood(BuildContext context) async {
    final newItem = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddFood()));
    if (newItem != null) {
      await _foodService.addFood(newItem);
      _fetchFoods(); // Refresh the list
    }
  }

  Future<void> _handleRefresh() async {
    // Refresh the food list
    await Future.delayed(Duration(seconds: 1)); // Simulate a refresh delay
    _fetchFoods(); // Re-fetch foods from the service
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.limeAccent,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', scale: 12),
            const SizedBox(width: 8),
            const Text(
              'Second Serving',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  fontFamily: 'cursive'),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SentRequestsScreen(
                      userId: _authService.currentUser!.uid),
                ),
              );
            },
            icon: const Icon(Icons.send_and_archive),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationsScreen(
                        donorId: _authService.currentUser!.uid)),
              );
            },
            icon: const Icon(Icons.notifications_active_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: StreamBuilder<List<Food>>(
            stream: _foodController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No food available.'));
              }

              final foods = snapshot.data!;
              final availableFoods = foods
                  .where((food) => food.expire.isAfter(DateTime.now()))
                  .toList();

              if (availableFoods.isEmpty) {
                return Center(child: Text('No available food items.'));
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 9 / 15,
                ),
                itemCount: availableFoods.length,
                itemBuilder: (context, index) {
                  final food = availableFoods[index];
                  return FoodCard(item: food);
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.dining_outlined),
        onPressed: () => _navigateToAddFood(context),
        backgroundColor: Colors.lime,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: Colors.green[700],
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/india.png'), // Ensure the path is correct
                      ),
                    ),
                  ),
                  Text(
                    _authService.currentUser!.email!,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    'Share a Byte of Happiness!',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('My Donated Foods'),
              leading: Icon(Icons.fastfood),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyFoodsScreen(
                          userId: _authService.currentUser!.uid)), // Pass the current user ID
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () async {
                final sf = await SharedPreferences.getInstance();
                await _authService.signOut();
                sf.remove('email');
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
            ListTile(
              title: Text('Login'),
              leading: Icon(Icons.login), // Added icon for Login
              onTap: () async {
                final sf = await SharedPreferences.getInstance();
                await _authService.signOut();
                sf.remove('email');
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
            ListTile(
              title: Text('Signup'),
              leading: Icon(Icons.person_add), // Added icon for Signup
              onTap: () async {
                final sf = await SharedPreferences.getInstance();
                await _authService.signOut();
                sf.remove('email');
                Navigator.pushReplacementNamed(context, 'signup');
              },
            ),
            ListTile(
              title: Text('About Us'),
              leading: Icon(Icons.info),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


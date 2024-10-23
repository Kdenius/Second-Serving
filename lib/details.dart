// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
// import 'food.dart';
//
// class DetailsScreen extends StatelessWidget{
//   Food item;
//   DetailsScreen({
//     required this.item,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.background,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.width - (40),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Colors.grey,
//                         offset: Offset(3, 3),
//                         blurRadius: 5
//                     )
//                   ],
//                   image: DecorationImage(
//                       image: FileImage(File(item.path), scale: 11),
//                   )
//               ),
//             ),
//             const SizedBox(height: 30,),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30),
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Colors.grey,
//                       offset: Offset(3, 3),
//                       blurRadius: 5
//                   )
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             item.Name,
//                             style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   item.Quantity.toString(),
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       color: Theme.of(context).colorScheme.primary
//                                   ),
//                                 ),
//                                 Text(
//                                   item.Expire.toString(),
//                                   style: const TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey,
//                                       // decoration: TextDecoration.lineThrough
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 12,),
//                     Row(
//                       children: [
//                         Text('data1'),
//                         Text('data2'),
//                         Text('data3'),
//                         // MyMacroWidget(
//                         //   title: "Calories",
//                         //   value: pizza.macros.calories,
//                         //   icon: FontAwesomeIcons.fire,
//                         // ),
//                         // const SizedBox(width: 10,),
//                         // MyMacroWidget(
//                         //   title: "Protein",
//                         //   value: pizza.macros.proteins,
//                         //   icon: FontAwesomeIcons.dumbbell,
//                         // ),
//                         // const SizedBox(width: 10,),
//                         // MyMacroWidget(
//                         //   title: "Fat",
//                         //   value: pizza.macros.fat,
//                         //   icon: FontAwesomeIcons.oilWell,
//                         // ),
//                         // const SizedBox(width: 10,),
//                         // MyMacroWidget(
//                         //   title: "Carbs",
//                         //   value: pizza.macros.carbs,
//                         //   icon: FontAwesomeIcons.breadSlice,
//                         // ),
//                       ],
//                     ),
//                     const SizedBox(height: 40,),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 50,
//                       child: TextButton(
//                         onPressed: () {
//
//                         },
//                         style: TextButton.styleFrom(
//                             elevation: 3.0,
//                             backgroundColor: Colors.black,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)
//                             )
//                         ),
//                         child: const Text(
//                           "Take now",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//
//     );
//   }
//
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:secondserving/food.dart';
import 'package:secondserving/food_request.dart';
import 'package:secondserving/food_request_service.dart';
class DetailsScreen extends StatelessWidget {
  final Food item;
  final FoodRequestService _foodRequestService = FoodRequestService(); // New service instance


  DetailsScreen({
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
                decoration: InputDecoration(hintText: "Enter food name"),
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
                // Get the current user's ID
                String userId = "currentUserId"; // Replace with actual user ID logic

                FoodRequest foodRequest = FoodRequest(
                  id: '',
                  userId: userId,
                  foodId: item.id,
                  foodName: requestDetails,
                  requestedAt: DateTime.now(),
                  location: "User Location", // You can collect the user's location
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  ),
                ],
                image: DecorationImage(
                  image: FileImage(File(item.imagePath), scale: 11),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item.quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  'Expires on: ${item.expire.toLocal().toString().split(' ')[0]}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Location: ${item.location}',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Mobile: ${item.mobile}',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          // Implement take action
                          _sendFoodRequest(context);
                        },
                        style: TextButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Take now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

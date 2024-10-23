// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'food.dart';
//
// class TakeFood extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _TakeFood();
// }
//
// class _TakeFood extends State<TakeFood> {
//   List<Food> tli = [
//     Food(
//         Name: 'Apple',
//         Did: 101,
//         Expire: DateTime(2024, 12, 31),
//         Quantity: 5.0,
//         Location: 'Refrigerator',
//         path:
//             '/storage/emulated/0/Android/data/com.example.secondserving/files/jak.jpg'),
//     Food(
//         Name: 'Banana',
//         Did: 101,
//         Expire: DateTime(2024, 12, 31),
//         Quantity: 5.0,
//         Location: 'Refrigerator',
//         path:
//             '/storage/emulated/0/Android/data/com.example.secondserving/files/jak.jpg'),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final item = ModalRoute.of(context)!.settings.arguments == null? null :ModalRoute.of(context)!.settings.arguments as Food;
//     if(item != null){
//     setState(() {
//       tli.add(item);
//     });
//     }
//     return Scaffold(
//       backgroundColor: Colors.yellow[200],
//       appBar: AppBar(
//         title: Text('Requested Food'),
//         centerTitle: true,
//         backgroundColor: Colors.orangeAccent,
//       ),
//       body: Column(
//         children: tli
//             .map((quote) => TakeCard(
//                   food: quote,
//                   delete: () {
//                     setState(() {
//                       tli.remove(quote);
//                     });
//                   },
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }
//
// class TakeCard extends StatelessWidget {
//   final food;
//   final VoidCallback delete;
//   const TakeCard({required this.food, required this.delete});
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
//       child: Padding(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               food.Name,
//               style: TextStyle(fontSize: 20, color: Colors.deepPurpleAccent),
//             ),
//             SizedBox(height: 10),
//             Text(food.Expire.toString(),
//                 style: TextStyle(fontSize: 25, color: Colors.blue)),
//             TextButton(
//               onPressed: delete,
//               child: Icon(Icons.delete),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

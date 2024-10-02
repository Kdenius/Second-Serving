import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'details.dart';
import 'food.dart';

class FoodCard extends StatelessWidget{

  Food item;
  FoodCard({
    required this.item,
});
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
              builder: (BuildContext context) =>
                  DetailsScreen(
                  item : item
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Set the border radius
                  child:  Image.file(File(item.path), fit: BoxFit.cover, height: 110, width: 165,),

            ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: state.pizzas[i].isVeg
                      //     ? Colors.green
                         color : Colors.green,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        // .isVeg
                        //     ? "VEG"
                        //     : "NON-VEG",
                        'VEG',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        'Category',
                        style: TextStyle(
                            color: Colors.lime,
                            fontWeight: FontWeight.w800,
                            fontSize: 10
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                item.Name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                item.Expire.toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
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
                          item.Quantity.toString(),
                          style: TextStyle(fontSize: 6, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          // "\$${state.pizzas[i].price}.00",
                          'kg',
                          style: TextStyle(fontSize: 6, color: Colors.grey.shade500, fontWeight: FontWeight.w700, ),
                        ),
                      ],
                    ),
                    IconButton(onPressed: () {
                      Navigator.of(context).pushNamed('take_food', arguments: item);
                    }, icon: const Icon(Icons.add_box))
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                item.Location  ,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
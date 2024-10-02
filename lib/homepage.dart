import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secondserving/add_food.dart';
import 'package:secondserving/food_card.dart';
import 'package:secondserving/login.dart';
import 'package:secondserving/take_food.dart';
// import 'package:secondserving/take_food.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'food.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String email = 'xyz';
  List<Food> li = [
    Food(
        Name: 'Apple',
        Did: 101,
        Expire: DateTime(2024, 12, 31),
        Quantity: 5.0,
        Location: 'Refrigerator',
        path: '/storage/emulated/0/Android/data/com.example.secondserving/files/jak.jpg'),
    Food(
        Name: 'Banana',
        Did: 101,
        Expire: DateTime(2024, 12, 31),
        Quantity: 5.0,
        Location: 'Refrigerator',
        path: '/storage/emulated/0/Android/data/com.example.secondserving/files/jak.jpg'
    ),
    Food(
        Name: 'Mango',
        Did: 101,
        Expire: DateTime(2024, 12, 31),
        Quantity: 5.0,
        Location: 'Refrigerator',
        path: '/storage/emulated/0/Android/data/com.example.secondserving/files/jak.jpg'),
    Food(
        Name: 'Khichadi',
        Did: 101,
        Expire: DateTime(2024, 12, 31),
        Quantity: 5.0,
        Location: 'Refrigerator'),
    Food(
        Name: 'Kadhi',
        Did: 101,
        Expire: DateTime(2024, 12, 31),
        Quantity: 5.0,
        Location: 'Refrigerator'),
  ];

  void _navigateToAddFood() async {
    final newitem = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddFood()));
    if(newitem != null){
      setState(() {
        li.add(newitem);
      });
    }
    _handleRefresh();
  }

  Future<void> _handleRefresh() async{
    DateTime curr = DateTime.now();
    setState(() {
      li.removeWhere((item) => item.Expire.isBefore(curr));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
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
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TakeFood()));
          }, icon: const Icon(Icons.send_and_archive)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_active_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 9 / 15),
              itemCount: li.length,
              itemBuilder: (context, int i) {
                return FoodCard(item: li[i]);
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.dining_outlined),
        onPressed: _navigateToAddFood,
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
                    image: AssetImage('/images/india.png'),
                  ),
                ),
              ),
              Text(
                "User 1",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                email,
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
            ListTile(
              title: Text('Login'),
              onTap: (){},
            ),
            ListTile(
              title: Text('Signup'),
              onTap: (){},
            ),
            ListTile(
              title: Text('Logout'),
              onTap: ()async{
                final sf = await SharedPreferences.getInstance();
                sf.remove('email');
                Navigator.pushReplacementNamed(context, 'login');
              },
            )
          ],
        ),
      ),
    );
  }
}

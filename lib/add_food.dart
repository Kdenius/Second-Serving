import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secondserving/food.dart';

class AddFood extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddFood();
}

class _AddFood extends State<AddFood>{
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool isloading = false;
  var name = TextEditingController();
  var year = TextEditingController();
  var month = TextEditingController();
  var day = TextEditingController();
  var hr = TextEditingController();
  var min = TextEditingController();
  var qua = TextEditingController();

  // @override
  // void dispose() {
  //   _passwordController.dispose();
  //   _confirmPasswordController.dispose();
  //   super.dispose();
  // }

  Future<void> getImage(bool fromCamera) async {
    try {
      final pickedImage = await _picker.pickImage(
          source: fromCamera ? ImageSource.camera : ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _sendData() async{
    final dir = await getExternalStorageDirectory();
    try {
      print(dir!=null ? '${dir.path}/${name.text}.jpg' : '');
      print(_image);
      await _image?.copy(dir!=null ? '${dir.path}/${name.text}.jpg' : '');
    }
    catch (e) {
      print('Error copying file: $e');
    }
    final item = new Food(
        Name: name.text,
        Did: 101,
        Expire: DateTime(int.parse(year.text), int.parse(month.text), int.parse(day.text), int.parse(hr.text),int.parse(min.text),),
        // Expire: DateTime(2005, 4, 16, 15, 30),
        Quantity: double.parse(qua.text),
        Location: 'Refrigerator',
        path: '${dir?.path}/${name.text}.jpg'
    );
    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Food'),
        backgroundColor: Colors.limeAccent,

      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child:Center(
          child: Container(
              width: 340,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image == null
                        ? Container() // Placeholder or some other UI element
                        : Image.file(_image!, height: 200, width: 200),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 2,
                              )
                          ),
                          border: OutlineInputBorder(),
                          hintText: "ex. rice",
                          labelText: "NAME"
                      ),
                    ),
                    Container(height: 10,),
                    TextField(
                      controller: qua,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 2,
                              )
                          ),
                          border: OutlineInputBorder(),
                          hintText: "kg",
                          labelText: "QUANTITY"
                      ),
                    ),
                    Container(height: 10,),
                    Text('Expiry'),
                    Container(height: 10,),
                    //for date
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: year,
                            decoration: InputDecoration(
                              hintText: 'yyyy',
                            ),
                          ),
                        ),
                        Text('/'),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: month,
                            decoration: InputDecoration(
                              hintText: 'mm',
                            ),
                          ),
                        ),
                        Text('/'),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: day,
                            decoration: InputDecoration(
                              hintText: 'dd',
                            ),
                          ),
                        ),
                        SizedBox(width: 8), // Add spacing between text fields
                        SizedBox(width: 8), // Add spacing between text fields
                        Expanded(
                          child: TextField(
                            controller: hr,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'hour',
                            ),
                          ),
                        ),
                        Text(':'),
                        Expanded(
                          child: TextField(
                            controller: min,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'min',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text('Upload Image'),
                    Row(
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () => getImage(true),
                            icon: Icon(Icons.camera_alt),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () => getImage(false),
                            icon: Icon(Icons.photo_camera_back_outlined),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:_sendData,
        backgroundColor: Colors.lime,
        child: Icon(Icons.done),
      ),
    );
  }
}
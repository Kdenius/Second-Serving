import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secondserving/auth_service.dart';
import 'package:secondserving/food.dart';

class AddFood extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  final AuthService _authService = AuthService();

  final nameController = TextEditingController();
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  final dayController = TextEditingController();
  final hourController = TextEditingController();
  final minuteController = TextEditingController();
  final quantityController = TextEditingController();
  final mobileController = TextEditingController();

  Future<void> getImage(bool fromCamera) async {
    try {
      final pickedImage = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _sendData() async {
    if (nameController.text.isEmpty || quantityController.text.isEmpty ||
        yearController.text.isEmpty || monthController.text.isEmpty ||
        dayController.text.isEmpty || hourController.text.isEmpty ||
        minuteController.text.isEmpty || _image == null) {
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image.')),
      );
      return;
    }

    final dir = await getExternalStorageDirectory();
    final imagePath = '${dir?.path}/${nameController.text}.jpg';

    try {
      await _image?.copy(imagePath);
      final item = Food(
        id: '',
        name: nameController.text,
        userId: _authService.currentUser!.uid, // Change this as needed
        expire: DateTime(
          int.parse(yearController.text),
          int.parse(monthController.text),
          int.parse(dayController.text),
          int.parse(hourController.text),
          int.parse(minuteController.text),
        ),
        quantity: double.parse(quantityController.text),
        location: 'Refrigerator',
        imagePath: imagePath,
        mobile: mobileController.text,
      );
      Navigator.pop(context, item);
    } catch (e) {
      print('Error saving food item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Food'),
        backgroundColor: Colors.limeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Center(
          child: Container(
            width: 340,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _image == null
                      ? Container() // Placeholder for image
                      : Image.file(_image!, height: 200, width: 200),
                  SizedBox(height: 10),
                  _buildTextField(nameController, "NAME", "ex. rice"),
                  SizedBox(height: 10),
                  _buildTextField(quantityController, "QUANTITY", "kg"),
                  SizedBox(height: 10),
                  Text('Expiry Date & Time'),
                  SizedBox(height: 10),
                  _buildDateTimeInput(),
                  SizedBox(height: 10),
                  _buildTextField(mobileController, "MOBILE", "+91"),
                  SizedBox(height: 20),
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
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendData,
        backgroundColor: Colors.lime,
        child: Icon(Icons.done),
      ),
    );
  }

  TextField _buildTextField(TextEditingController controller, String label, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(),
        hintText: hint,
        labelText: label,
      ),
    );
  }

  Row _buildDateTimeInput() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(yearController, 'yyyy', 'yyyy'),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _buildTextField(monthController, 'mm', 'mm'),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _buildTextField(dayController, 'dd', 'dd'),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _buildTextField(hourController, 'hour', 'hour'),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _buildTextField(minuteController, 'min', 'min'),
        ),
      ],
    );
  }
}

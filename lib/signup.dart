import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'homepage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void clear()
  {
    _passwordController.text = "";
    _confirmpassController.text = "";
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/login_background.png'), fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.limeAccent,
        appBar: AppBar(
          backgroundColor: Colors.white60,
          title: Text('Sign Up Page'),
          titleTextStyle: TextStyle(backgroundColor: Colors.transparent,fontSize: 24.0, fontWeight: FontWeight.bold,fontFamily: 'TimesNewRoman', color: Colors.red),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmpassController,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter confirm password';
                    }
                    else if(value != _passwordController.text)
                    {
                      return 'Both password doesn\'t match!';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                Row(

                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade900,
                          ),
                        )
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _usernameController.text,
                          password: _passwordController.text).then((value) {
                        print("Successfully created");
                        clear();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      }).onError((error,stackTrace) {
                        Fluttertoast.showToast(msg: error.toString(),timeInSecForIosWeb: 3);
                      }
                      );
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
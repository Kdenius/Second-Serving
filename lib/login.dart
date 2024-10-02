import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secondserving/homepage.dart';
import 'package:secondserving/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // bool _isvalid = true;

  void clear()
  {
    _passwordController.text="";
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      ),
      child: Scaffold(
        backgroundColor: Colors.limeAccent,
        appBar: AppBar(
          backgroundColor: Colors.white60,
          title: Text('Login Page'),
          titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,fontFamily: 'TimesNewRoman', color: Colors.red),
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
                  'Login',
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
                    labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // else if(_isvalid==false)
                    // {
                    //   _isvalid = true;
                    //   return 'invalid username/password';
                    // }
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                Row(

                  children: [
                    Text(
                      'Don\'t have account?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                        },
                        child: Text(
                          'Sign up',
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
                  onPressed: () async{
                    SharedPreferences sf = await SharedPreferences.getInstance();
                    if (_formKey.currentState?.validate() ?? false) {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _usernameController.text,
                          password: _passwordController.text
                      ).then((value) {
                        // _isvalid = true;
                        sf.setString('email', _usernameController.text);
                        clear();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      }).onError((error,stackTracec){
                        // _isvalid=false;
                        // _formKey.currentState?.validate();
                        Fluttertoast.showToast(msg: error.toString(), timeInSecForIosWeb: 3);
                      }
                      );
                    }
                    // SharedPreferences sf = await SharedPreferences.getInstance();
                    // sf.setString('email', _usernameController.text);
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    'Sign in',
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
import 'package:flutter/material.dart';
import 'package:learnflutter/main.dart'; // Assuming SAVE_KEY_NAME is defined here
import 'package:learnflutter/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 150),
              Image.asset(
                'assets/images/amallogo-removebg-preview.png',
                height: 100,
              ),
              Text(
                'Login Page',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Value is Empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Value is Empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    checkLogin(context);
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkLogin(BuildContext ctx) async {
    final _username = _usernameController.text;
    final _password = _passwordController.text;

    if (_username == _password) {
      print('username pass match');
      // Go to home
      final SharedPreferences _sharedPrefs =
          await SharedPreferences.getInstance();
      _sharedPrefs.setBool(
          SAVE_KEY_NAME, true); // Save a boolean value to SharedPreferences
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => HomePage(title: 'Home')));
    } else {
      final _errorMsg = 'Username Password Does not match';
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          content: Text(_errorMsg),
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:learnflutter/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              signout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: const Text(
          'Shared Pref Sample',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontFamily: 'Sans Serif'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You Have Entered To Home Page',
            ),
          ],
        ),
      ),
    );
  }

  signout(BuildContext ctx) async {
    final _sharedPref = await SharedPreferences.getInstance();
    await _sharedPref.clear();

    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => LoginPage(title: 'Login Page')),
        (route) => false);
  }
}

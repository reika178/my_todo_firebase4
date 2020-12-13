import 'package:flutter/material.dart';
import 'package:my_todo_app_firebase4/presentation/login/login_page.dart';
import 'package:my_todo_app_firebase4/presentation/signup/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Home(),
      );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/hyde.jpeg'
            ) ,
            RaisedButton(
              color: Colors.blue[100],
              child: Text('SignUp'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              }
            ),
            RaisedButton(
              color: Colors.blue[200],
              child: Text('Login'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            ),
          ],
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_todo_app_firebase4/presentation/login/login_page.dart';
import 'package:my_todo_app_firebase4/presentation/signup/signup_page.dart';
import 'package:provider/provider.dart';
import 'presentation/main/main_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Todo App'),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
              return Center(
                child: Column(
                  children: [
                    RaisedButton(
                      child: Text('SignUp'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      }
                    ),
                    RaisedButton(
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
              );
            }
          ),
        ),
      )
    );
  }
}

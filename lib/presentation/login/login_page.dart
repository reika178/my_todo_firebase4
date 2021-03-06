import 'package:flutter/material.dart';
import 'package:my_todo_app_firebase4/presentation/login/login_model.dart';
import 'package:my_todo_app_firebase4/presentation/todo_list/todo_list_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();

    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Consumer<LoginModel>(
          builder: (context, model, child) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'email'
                      ),
                      controller: mailController,
                      onChanged: (text) {
                        model.mail = text;
                      }
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'password'
                      ),
                      obscureText: true,
                      controller: passwordController,
                      onChanged: (text) {
                        model.password = text;
                      }
                    ),
                    RaisedButton(
                      color: Colors.blue[200],
                      child: Text('Login'),
                      onPressed: () async {
                        try {
                          await model.login();
                          await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return TodoListPage();
                          }),
                          );
                        } catch(e) {
                          _showDialog(context, e.toString());
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  Future _showDialog(
    BuildContext context,
    String title,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
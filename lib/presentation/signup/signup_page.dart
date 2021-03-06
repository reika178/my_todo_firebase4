import 'package:flutter/material.dart';
import 'package:my_todo_app_firebase4/presentation/signup/signup_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();

    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Signup'),
        ),
        body: Consumer<SignUpModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'mail adress'
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
                    child: Text('OK'),
                    color: Colors.blue[100],
                    onPressed: () async {
                      try {
                        await model.signUp();
                        _showDialog(context, 'Signup!');
                      } catch(e) {
                        _showDialog(context, e.toString());
                      }
                    },
                  ),
                ],
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
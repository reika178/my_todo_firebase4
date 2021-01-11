import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _active = true;
  void _changeSwitch(bool e) => setState(() => _active = e);
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('画像入れる'),
                  Switch(
                    value: _active,
                    // activeColor: Colors.orange,
                    // activeTrackColor: Colors.red,
                    // inactiveThumbColor: Colors.blue,
                    // inactiveTrackColor: Colors.green,
                    onChanged: _changeSwitch,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 300,
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(_image)),
              ),
              FloatingActionButton(
                 onPressed: getImageFromGallery, //ギャラリーから画像を取得
                 tooltip: 'Pick Image From Gallery',
                 child: Icon(Icons.photo_library),
               ),
               /*
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('応援メッセージ入れる'),
                  Switch(
                    value: _active,
                    // activeColor: Colors.orange,
                    // activeTrackColor: Colors.red,
                    // inactiveThumbColor: Colors.blue,
                    // inactiveTrackColor: Colors.green,
                    onChanged: _changeSwitch,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  enabled: true,
                  maxLength: 30,
                  maxLengthEnforced: false,
                  obscureText: false,
                  // controller: _textEditingController,
                  // onChanged: _handleText,
                  // onSubmitted: _submission,
                ),
              )
              */
            ],
          ),
        ));
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
}

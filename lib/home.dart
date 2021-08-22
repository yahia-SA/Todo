import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import 'main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _name = " ";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print("the path $path");
    return File('$path/Data.txt');
  }

  final _text = TextEditingController();

  Future<void> readData() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      setState(() {
        _name = contents;
      });
    } catch (e) {
      return null;
    }
  }

  Future<void> _writeData() async {
    final file = await _localFile;
    await file.writeAsString("Hello My Name is ${_text.text}");
    _text.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "File Operations",
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _text,
            onSubmitted: (value){
              _writeData();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter',
            ),
          ),
          defaubutton(
            function: _writeData,
            title: ("Save to file"),
          ),
          SizedBox(
            height: 10,
          ),
          defaubutton(
            function: readData,
            title: ("Read from file"),
          ),
          SizedBox(
            height: 10,
          ),
          Text(_name, style: TextStyle(fontSize: 24, color: Colors.red)),
        ],
      ),
    );
  }
}

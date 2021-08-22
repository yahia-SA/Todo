import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class Shared extends StatefulWidget {
  @override
  _SharedState createState() => _SharedState();
}

class _SharedState extends State<Shared> {
  final _text = TextEditingController();
  late String _name = " ";
  void readData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('key1') ?? " ";
    });
  }

  void saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('key1', "Hello My Name is ${_text.text}");
  }

  void deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('key1');
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
          TextField(
            controller: _text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter',
            ),
            onSubmitted: (value){
              saveData();
            },
          ),
          defaubutton(
            function: saveData,
            title: ("Save To file"),
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
          SizedBox(
            height: 10,
          ),
          defaubutton(
            function: deleteData,
            title: ("Delete from file"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iti_task9/Home.dart';
import 'Sql/sql.dart';
import 'shared_preferences.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Welcome',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defaubutton(
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                },
                title: ("Path_Provider"),
              ),
              SizedBox(
                height: 20,
              ),
              defaubutton(
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Shared(),
                      ));
                },
                title: ("Shared_Preferences"),
              ),
              SizedBox(
                height: 20,
              ),
              defaubutton(
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Sql(),
                      ));
                },
                title: ("Sql"),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}

Widget defaubutton({
  double width = 200,
  Color background = Colors.white,
  required VoidCallback function,
  required String title,
}) =>
    Container(
      width: width,
      child: ElevatedButton(
        onPressed: function,
        child: Text(title,style: TextStyle(color: background),),
      ),
    );

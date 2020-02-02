
import 'package:flutter/material.dart';

import 'infoSheet.dart';

class NavBar extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 60, 30, 20),
      child: Row(
        children: <Widget>[
          Text(
            'Day Count',
            style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 35, fontFamily: "ZillaSlab"),
          ),
          new Expanded(
            child: Row(

            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.indigo,
              //size: 35,
            ),
            padding: EdgeInsets.all(0),
            onPressed: () {
              showBottomSheet(
                    context: context,
                    builder: (context) => InfoSheet(),
              );
            },
          ),
          
        ]
      ),
    );
  }
}
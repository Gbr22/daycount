
import 'package:flutter/material.dart';

import '../dataHandler.dart';
import '../lang.dart';


class UnitTicker extends StatefulWidget {

  Map units;
  String unit;

  UnitTicker(Map units, String unit){
    this.units= units;
    this.unit = unit;
  }

  @override
  _UnitTickerState createState() => _UnitTickerState();
}


class _UnitTickerState extends State<UnitTicker> {
  
  bool _ticked;

  @override
  Widget build(BuildContext context) {
    var units = widget.units;
    var unit = widget.unit;

    _ticked = units[unit];

    firstUpper(String s){
      return '${s[0].toUpperCase()}${s.substring(1)}';
    }


    return Container(
      padding: EdgeInsets.all(5),
      width: 110,
      child: Row(
        children: <Widget>[
          Text(firstUpper(Lang.get(unit).toString())),
          Expanded(
            child: Container(),
          ),
          Checkbox(
            value: _ticked,
            onChanged: (bool val) {
              
              units[unit] = !units[unit];
              bool isOneTicked = false;
              for (bool val in units.values){
                if (val){
                  isOneTicked = true;
                  break;
                }
              }
              if (!isOneTicked){
                units[unit] = true;
              }
              

              setState(() {
                _ticked = units[unit];  
              });
            },
          )
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';



import '../dataHandler.dart';
import 'card.dart';
import 'navbar.dart';

class DayCardList extends StatefulWidget {
  @override
  _DayCardListState createState() => _DayCardListState();
}

class _DayCardListState extends State<DayCardList> {
  
  List<DayRecord> _records = [];

  update(List<DayRecord> rec){
    setState(() {
      _records = rec;
    });
  }
  @override
  void initState() {
    super.initState();
    recordUpdateStream.stream.listen((rec) {
      update(rec);
    });
  }

  Widget build(BuildContext context) {
    List<Widget> children = [
      NavBar()
    ];
    for (int i = 0; i < _records.length; i++){
      children.add(DayCard(_records[i]));
    }

    return ListView(
      children: children,
    );
  }
}
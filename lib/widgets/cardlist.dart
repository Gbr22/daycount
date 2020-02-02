
import 'package:flutter/material.dart';

import 'card.dart';

class DayCardList extends StatefulWidget {
  @override
  _DayCardListState createState() => _DayCardListState();
}

class _DayCardListState extends State<DayCardList> {
  
  List<DayRecord> _records = [
    new DayRecord("Alcohol free", DateTime.now()),
    new DayRecord("PMO free", DateTime.now()),
  ];

  Widget build(BuildContext context) {
    List<Widget> cards = [];
    for (int i = 0; i < _records.length; i++){
      cards.add(DayCard(_records[i]));
    }

    return ListView(          
      children: cards,
    );
  }
}
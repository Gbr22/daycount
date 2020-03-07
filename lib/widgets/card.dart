
import 'package:flutter/material.dart';

import '../dataHandler.dart';

import 'infoSheet.dart';



class DayCard extends StatelessWidget {
  
  DayRecord data;

  DayCard(DayRecord data){
    this.data = data;
  }
  


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String diffName = "since";
    int days = data.getDays();
    if (days < 0){
      diffName = "untill";
    }

    String timeString = '${days.abs()} days ${diffName}';
    if (days == 0){
      timeString = "Since today";
    }

    return GestureDetector(
      onTap: (){
        showBottomSheet(
          context: context,
          builder: (context) => InfoSheet(data),
        );
      },
      child: Container(
        
        margin: EdgeInsets.fromLTRB(25, 8, 25, 8),
        padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
              //color: Colors.black.withAlpha(15),
              color: Theme.of(context).primaryColor.withAlpha(25),
              blurRadius: 8,
              offset: Offset(0, 15))
            ],
        ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23, fontFamily: "ZillaSlab"),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                timeString,
                style: TextStyle(color:Colors.grey[800] ,fontWeight: FontWeight.normal, fontSize: 18, fontFamily: "Roboto"),
              ),
            ),
            
          ],
        )
      ),
    );
    
  }
}
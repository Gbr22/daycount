import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'lang.dart';

class DayRecord {
  String title;
  DateTime date;
  String id;
  
  Map units;
  static Map defaultUnits = {
    "month":false,
    "year":false,
    "week":false,
    "day":true
  };

  DayRecord(String title, DateTime date, String id, Map units){
    this.title = title;
    this.date = date;
    this.id = id;
    this.units = units;
  }
  
  int getDays(){
    return DateTime.now().difference(this.date).inDays;
  }

  String formattedTime(){
    List<List<dynamic>> map = [
      ["year",365],
      ["month",30],
      ["week",7],
      ["day",1]
    ];
    var days = this.getDays();
    String diffName = Lang.get("ago");
    
    if (days < 0){
      diffName = Lang.get("until");
    }
    if (days == 0){
      return "Today";
    }

    int absDays = days.abs();

    Map<String, int> count = {
      
    };
    for(List<dynamic> entry in map){
      if (this.units[entry[0]] == true){
        var countOfUnit = (absDays/entry[1]).floor();
        var daysUsedUp = countOfUnit*entry[1];
        count[entry[0]] = countOfUnit;
        absDays-= daysUsedUp;
      }
    }

    String out = "";
    for(List<dynamic> entry in map){
      out+=this.units[entry[0]] == true ? "${count[entry[0]]} ${Lang.get(entry[0])} " : "";
    }

    return out+diffName;
  }

  static fromJson(Map<String, dynamic> json){
    Map units = defaultUnits;
    if (json["units"] != null){
      units = json["units"];
    }

    return DayRecord(
      json['title'], DateTime.fromMillisecondsSinceEpoch(json['date']), json['id'],
      units
    );
  }


  Map<String, dynamic> toJson() => {
    'title': title,
    'date': date.millisecondsSinceEpoch,
    'id': id,
    'units':units
  };
}

StreamController<List<DayRecord>> recordUpdateStream = new StreamController();

List<DayRecord> records = [];

Future<List<DayRecord>> getRecords() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> stringList = prefs.getStringList("records");
  if (stringList == null){
    return records;
  }
  List<DayRecord> rec = [];
  for (var elem in stringList){
    rec.add(DayRecord.fromJson(json.decode(elem)));
  }
  
  records = rec;
  return records;
}
void removeRecord(DayRecord record) async {
  records.remove(record);

  saveRecords();
}
void saveRecords() async {
  final prefs = await SharedPreferences.getInstance();
  recordUpdateStream.add(records);
  List<String> stringList = [];
  for (var elem in records){
    var encoded = json.encode(elem.toJson());
    stringList.add(encoded);
    print("saving, "+ encoded);
  }
  
  prefs.setStringList("records", stringList);
}
void addRecord(DayRecord record) async {
  records.add(record);
  saveRecords();
}
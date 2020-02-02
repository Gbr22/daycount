import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DayRecord {
  String title;
  DateTime date;
  String id;
  DayRecord(String title, DateTime date, String id){
    this.title = title;
    this.date = date;
    this.id = id;
  }
  
  int getDays(){
    return DateTime.now().difference(this.date).inDays;
  }

  DayRecord.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = DateTime.fromMillisecondsSinceEpoch(json['date']),
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'title': title,
    'date': date.millisecondsSinceEpoch,
    'id': id,
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
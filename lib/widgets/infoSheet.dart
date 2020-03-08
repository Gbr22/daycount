import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../dataHandler.dart';
import 'card.dart';
import 'unitTicker.dart';

class InfoSheet extends StatefulWidget {

  DayRecord record;

  InfoSheet(DayRecord record){
    this.record = record;
  }

  @override
  _InfoSheetState createState() => _InfoSheetState();
}

class _InfoSheetState extends State<InfoSheet> {
  final _formKey = GlobalKey<FormState>();
  
  DateTime _datePicked;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Future<Null> _selectDate(BuildContext context) async {
    
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _datePicked,
      firstDate: DateTime(0),
      lastDate: DateTime(DateTime.now().year+1000)
    );
    if (picked != null && picked != _datePicked)
      setState(() {
        _datePicked = picked;
      });
  }
  final titleController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    bool add = widget.record == null;
    bool edit = !add;
    
    Map units = edit ? new Map.from(widget.record.units) : DayRecord.defaultUnits();

    if (edit){
      if (_datePicked == null){
        _datePicked = widget.record.date;
      }
      titleController.text = widget.record.title;
    } else {
      if (_datePicked == null){
        _datePicked = DateTime.now();
      }
    }

    return Container(
      color: Colors.transparent,
      child: Container(
        
        margin: EdgeInsets.only(top: 50),
        
        //height: 235,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          //color: Colors.red,
          borderRadius: BorderRadius.vertical(top:Radius.circular(18)),
          boxShadow: [
              BoxShadow(
              //color: Colors.black.withAlpha(15),
              color: Theme.of(context).primaryColor.withAlpha(50),
              blurRadius: 15,
              offset: Offset(0, 0))
          ],
        ),
        
        child: Container(
          child: Column(
            children:[
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    add ? "Add" : "Edit",
                    style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold, fontSize: 28, fontFamily: "ZillaSlab"),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child:Column(
                  children: <Widget>[
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text(dateFormat.format(_datePicked)),
                          )
                        ),
                        Expanded(
                          child: OutlineButton(
                            child: Text("Choose date"),
                            onPressed: (){
                              _selectDate(context);
                            },
                          ),
                        )
                        
                        
                      ],
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(),
                              ),
                              UnitTicker(units,"year"),
                              UnitTicker(units,"month"),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(),
                              ),
                              UnitTicker(units,"week"),
                              UnitTicker(units,"day"),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: 
                      Align(
                        alignment: Alignment.centerRight,
                        child:Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: edit ? Colors.red[900] : Colors.grey[300],
                                
                              ),
                              onPressed: add ? null : () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: new Text("Confirm Delete"),
                                      content: new Text("Are you sure you want to delete this record?"),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              color:Colors.amber[900],
                                            ),
                                              
                                          ),
                                          onPressed: () {
                                            removeRecord(widget.record);
                                            Navigator.of(context).pop(); //confirm dialog
                                            Navigator.of(context).pop(); //edit sheet
                                    
                                            Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                                backgroundColor: Theme.of(context).primaryColor,
                                                content: Text('Deleted')
                                              ));
                                          },
                                        ),
                                        new FlatButton(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color:Colors.grey[900],
                                            ),
                                              
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                );
                                
                              },
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              child:OutlineButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  if (_formKey.currentState.validate()) {
                                    // Process data.
                                    if (add){
                                      var record = DayRecord(
                                        titleController.text,
                                        _datePicked,
                                        DateTime.now().toString(),
                                        units
                                      );
                                    
                                      addRecord(record);
                                    } else {
                                      var record = widget.record;
                                      record.title = titleController.text;
                                      record.date = _datePicked;
                                      record.units = units;
                                      saveRecords();
                                    }
                                    

                                    Navigator.of(context).pop();
                                    Scaffold.of(context)
                                      .showSnackBar(SnackBar(
                                        backgroundColor: Theme.of(context).primaryColor,
                                        content: Text('Saved')
                                      ));
                                  }
                                },
                                child: Text('Save'),
                              ),
                            ),
                            OutlineButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                          ]
                        )
                      )
                    ),
                    
                  ],
                )
              )
            ]
          )
        ),
      ),
    );
  }
}
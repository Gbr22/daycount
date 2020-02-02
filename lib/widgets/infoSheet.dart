import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../dataHandler.dart';
import 'card.dart';

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
      lastDate: DateTime.now()
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
            color: Colors.indigo.withAlpha(50),
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
                  style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold, fontSize: 28, fontFamily: "ZillaSlab"),
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
                              removeRecord(widget.record);
                                  
                              Navigator.of(context).pop();
                              Scaffold.of(context)
                                .showSnackBar(SnackBar(
                                  backgroundColor: Colors.indigo,
                                  content: Text('Deleted')
                                ));
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
                                    var record = DayRecord(titleController.text, _datePicked, DateTime.now().toString());
                                  
                                    addRecord(record);
                                  } else {
                                    var record = widget.record;
                                    record.title = titleController.text;
                                    record.date = _datePicked;
                                    saveRecords();
                                  }
                                  

                                  Navigator.of(context).pop();
                                  Scaffold.of(context)
                                    .showSnackBar(SnackBar(
                                      backgroundColor: Colors.indigo,
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
    );
  }
}
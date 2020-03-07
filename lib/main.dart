import 'package:flutter/material.dart';

import 'dataHandler.dart';
import 'widgets/card.dart';
import 'widgets/cardlist.dart';
import 'widgets/navbar.dart';

void main() {
  runApp(App());
  initalFetch();
  print("Fetching");
}

const bg = const Color(0xFFF6F8F6);

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day counter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try runnpainting your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        
        primarySwatch: Colors.indigo,
        bottomSheetTheme: BottomSheetThemeData(
                        backgroundColor: Colors.black.withOpacity(0)),
      ),
      home: HomePage(title: 'Day counter'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}




void initalFetch() async {
  List<DayRecord> rec = await getRecords();
  recordUpdateStream.add(rec);
  print("Fetched");
  print(rec);
}



class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.grey[70],
      /* appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ), */
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            NavBar(),
            Expanded(child:DayCardList()),
            
          ],
        )
        
      ),
      
    );
  }
}

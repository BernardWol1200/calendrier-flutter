import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final _stream1 = Firestore.instance.collection('brews').snapshots();
    final _stream2 = Firestore.instance.collection('tasks').snapshots();
      return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              child: StreamBuilder(
                stream: _stream1,
                builder: (context,snapshot1){
                  return StreamBuilder(
                    stream : _stream2,
                    builder: (context, snapshot2){
                      if (!snapshot1.hasData){print ('ouaou2');}
                      else{
                        if (!snapshot1.hasData){print ('ouaou1');}
                        else {
                          return ListView.builder(
                            itemCount: snapshot2.data.documents.length,
                            itemBuilder: (context,index){
                              return Text  (snapshot1.data.documents[index].toString());
                            });
                          return Container();
                        }
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}

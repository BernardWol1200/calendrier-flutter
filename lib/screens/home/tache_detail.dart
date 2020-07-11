import 'package:calendrier/models/tache.dart';
import 'package:calendrier/models/user.dart';
import 'package:calendrier/services/database.dart';
import 'package:calendrier/shared/constants.dart';
import 'package:calendrier/shared/loading.dart';
import 'package:calendrier/sounds/speech_rec.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

class TacheDetail extends StatefulWidget {
  @override
  _TacheDetailState createState() => _TacheDetailState();
}

class _TacheDetailState extends State<TacheDetail> {
  //Map data = {};

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentDetails;
  int _currentImportance;
  DateTime _currentDate;
  bool _curFait = false;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final user = Provider.of<User>(context);
    if (arguments != null) print(arguments['parametre2']);

    final _stream2 = Firestore.instance
        .collection('taches')
        .where(FieldPath.documentId, isEqualTo: arguments['parametre'])
        .snapshots();
    return StreamBuilder(
        //stream: DatabaseService(uid: data['parametre2']).uneTache,
        stream: _stream2,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Tache tache = snapshot.data;
            DocumentSnapshot ds2 = snapshot.data.documents[0];
            return Scaffold(
              appBar: AppBar(
                title: Text(ds2["nom"]),
              ),
              body: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Insert',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: ds2["nom"],
                        decoration: textInputDecoration,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: ds2["details"],
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: textInputDecoration,
                        onChanged: (val) =>
                            setState(() => _currentDetails = val),
                      ),
                      SizedBox(height: 20.0),
                      //Discours(),                      
                      //SizedBox(height: 20.0),
                      //dropdown
                      /*                 DropdownButtonFormField(
                        decoration: textInputDecoration,
                        value: _currentSugars ?? tacheData.sugars,
                        items: sugars.map((sugar) {
                          return DropdownMenuItem(
                            value: 0,
                            child: Text('$sugar sugars'),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => _currentSugars = val),
                      ), */
                      //slider
                      Slider(
                        value: (_currentImportance ?? 200).toDouble(),
                        activeColor: Colors.brown[_currentImportance ?? 100],
                        inactiveColor: Colors.brown[_currentImportance ?? 100],
                        min: 100,
                        max: 900,
                        divisions: 8,
                        onChanged: (val) =>
                            setState(() => _currentImportance = val.round()),
                      ),
                      Text("Fait"),
                      Checkbox(
                        value: _curFait,
                        onChanged: (bool value) {
                          setState(() {
                            _curFait = value;
                          });
                        },
                      ),

                      RaisedButton(
                        color: Colors.blueAccent[400],
                        child: Text(
                          ds2["prochDate"].toDate().day.toString() +
                              '/' +
                              ds2["prochDate"].toDate().month.toString() +
                              '/' +
                              ds2["prochDate"].toDate().year.toString() +
                              ' ' +
                              ds2["prochDate"].toDate().hour.toString() +
                              ':' +
                              ds2["prochDate"].toDate().minute.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true, onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            setState(() => _currentDate = date.toLocal());
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.fr);

                          /*(date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now());*/
                        },
                      ),
                      RaisedButton(
                        color: Colors.blueAccent[400],
                        child: Text(
                          'Mettre à jour',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid)
                                .updateUserTache(
                                    _currentName ?? ds2["nom"],
                                    _currentDetails ?? ds2["details"],
                                    _currentImportance ?? ds2["importance"],
                                    _currentDate ?? ds2["dateProchaine"],
                                    //_currentDate ?? ds2["dateProchaine"],
                                    user.uid,
                                    arguments['parametre']);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ],
                    //SizedBox(height: 20.0),
                     //child: new Discours(),

                  )),
            );
          } else {
            return Loading();
          }
        });
  }
}

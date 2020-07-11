import 'package:calendrier/models/user.dart';
import 'package:calendrier/services/database.dart';
import 'package:calendrier/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:calendrier/shared/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class TachesFormNew extends StatefulWidget {
  @override
  _TachesFormNewState createState() => _TachesFormNewState();
}

class _TachesFormNewState extends State<TachesFormNew> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  //form values
  String _currentName;
  String _currentDetails;
  int _currentImportance;
  DateTime _currentDate;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    var now2 = DateTime.now();
    // return StreamBuilder<UserData>(
    //     stream: DatabaseService(uid: user.uid).userData,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         UserData userData = snapshot.data;
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Insert',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: '',
              decoration: textInputDecoration,
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            SizedBox(height: 20.0),
            //dropdown
            /*                 DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentDetails ?? userData.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: 0,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentDetails = val),
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
            RaisedButton(
              color: Colors.blueAccent[400],
              child: Text(
                now2.day.toString() +
                    '/' +
                    now2.month.toString() +
                    '/' +
                    now2.year.toString() +
                    ' ' +
                    now2.hour.toString() +
                    ':' +
                    now2.minute.toString(),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                DatePicker.showDateTimePicker(context, showTitleActions: true,
                    onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                  setState(() => _currentDate = date.toLocal());
                }, currentTime: DateTime.now(), locale: LocaleType.fr);

                /*(date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now());*/
              },
            ),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                'Insertion',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print('cepresseCon');
                if (_formKey.currentState.validate()) {
                  print('ceValideCon');
                  await DatabaseService(uid: user.uid).insertUserData(
                      _currentName ?? 't',
                      _currentDetails ?? '1',
                      _currentImportance ?? 1,
                      _currentDate ?? now2.toString(),
                      user.uid);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ));
    //   } else {
    //     return Loading();
    //   }
    // });
  }
}

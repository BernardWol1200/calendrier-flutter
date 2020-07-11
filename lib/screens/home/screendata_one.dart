import 'package:calendrier/models/tache.dart';
import 'package:calendrier/screens/home/tache_form_new.dart';
import 'package:calendrier/screens/home/tache_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Attempt extends StatefulWidget {
  @override
  _AttemptState createState() => _AttemptState();
}

class _AttemptState extends State<Attempt> {
  @override
  Widget build(BuildContext context) {
    void _showNewPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: TachesFormNew(),
            );
          });
    }

    void _showTacheDetails(String pParam, String pParam2) {
      print('param caught $pParam et $pParam2');
      Navigator.of(context).pushNamed("/TacheDetail", arguments: {
        'parametre': pParam,
        'parametre2': pParam2,
      });
    }

    //final tachesa = Provider.of<List<Tache>>(context) ?? [];

    var now = DateTime.now();
    var _year = now.year;
    var _month = now.month;
    var _day = now.day;
    var _hour = now.hour;
    bool _dejaRefresh;

    var _leJour = DateTime(_year, _month, _day, 0);
    var _leJourdApres = DateTime(_year, _month, _day, 0);

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      print('aya ' + arguments['paramJour'].toString());
      _leJour = arguments['paramJour'];
    }

    _leJourdApres = _leJour.add(Duration(days: 1));
    //print('lejour'+_leJour.toString()+'_leJourdApres'+_leJourdApres.toString());

    final _stream1 = Firestore.instance.collection('brews').snapshots();
    var _stream2 = Firestore.instance
        .collection('taches')
        .where("prochDate", isGreaterThanOrEqualTo: _leJour)
        .where("prochDate", isLessThan: _leJourdApres)
        .snapshots();

    //final _stream2 = Firestore.instance.collection('taches').where('importance', isEqualTo: 1).snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Text(_leJour.day.toString() + '/' + _leJour.month.toString()),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.add_circle),
                onPressed: () => _showNewPanel(),
                label: Text('')),
            FlatButton.icon(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  _leJour = _leJour.subtract(Duration(days: 1));
                  Navigator.of(context).pushNamed("/ScreenOne", arguments: {
                    'paramJour': _leJour,
                  });
                },
                label: Text('')),
            FlatButton.icon(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
                  _leJour = _leJour.add(Duration(days: 1));

                  Navigator.of(context).pushNamed("/ScreenOne", arguments: {
                    'paramJour': _leJour,
                  });
                },
                label: Text('')),
            FlatButton.icon(
                icon: Icon(Icons.today),
                onPressed: () {
                  _leJour = DateTime(_year, _month, _day, 0);
                  Navigator.of(context).pushNamed("/ScreenOne", arguments: {
                    'paramJour': _leJour,
                  });
                },
                label: Text('')),

            /*
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  label: Text('logout')),
                  */
          ],
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                child: StreamBuilder(
                  stream: _stream1,
                  builder: (context, snapshot1) {
                    return StreamBuilder(
                      stream: _stream2,
                      // ignore: missing_return
                      builder: (context, snapshot2) {
                        if (!snapshot1.hasData) {
                          print('ouaou1apadedata');
                          return new Text('apu');
                        } else {
                          if (!snapshot1.hasData) {
                            print('ouaou2apadedata');
                            return new Text('apunonpu');
                          } else {
                            //DocumentSnapshot ds2 = snapshot2.data.documents[0];
                            //print(ds2["name"]);

                            return ListView.builder(
                                itemCount: snapshot2.data.documents.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot ds2 =
                                      snapshot2.data.documents[index];
                                  /*
                                  var date = new DateTime(ds2["prochDate"].toDate());
                                  var diff = date.difference(now);
                                  */
                                  return new Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Card(
                                        /*routes: <String, WidgetBuilder>{
                                "/TacheDetail":(BuildContext context) => new TacheDetail()
                                OnPressed:(){Navigator.of(context).pushNamed("/TacheDetail");}
                              },          */
                                        margin: EdgeInsets.fromLTRB(
                                            20.0, 6.0, 20.0, 0.0),
                                        child: ListTile(
                                          title: new Text(ds2["nom"]),
                                          subtitle: new Text(ds2["details"]),
                                          trailing: new Text(ds2["prochDate"]
                                                  .toDate()
                                                  .day
                                                  .toString() +
                                              '/' +
                                              ds2["prochDate"]
                                                  .toDate()
                                                  .month
                                                  .toString() +
                                              ' ' +
                                              ds2["prochDate"]
                                                  .toDate()
                                                  .hour
                                                  .toString() +
                                              'h'),
                                          // trailing: new  Text(diff.inDays.toString()),
                                          //Navigator.pop(context);
                                          onTap: () {
                                            _showTacheDetails(
                                                ds2.documentID, ds2["nom"]);
                                          },
                                        ),
                                      ));
                                });
                          }
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

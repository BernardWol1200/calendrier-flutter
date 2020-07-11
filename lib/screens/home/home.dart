import 'package:calendrier/models/tache.dart';
import 'package:calendrier/screens/home/screendata_One.dart';
//import 'package:calendrier/screens/home/tache_list.dart';
//import 'package:calendrier/screens/home/settings_form.dart';
//import 'package:calendrier/screens/home/tache_form_new.dart';
import 'package:calendrier/services/auth.dart';
import 'package:calendrier/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'tache_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    /*
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

  void _showNewPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: TachesFormNew(),
            );
          });    
  }
*/
    return StreamProvider<List<Tache>>.value(
      value: DatabaseService().taskb,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Trucs à faire'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
/*
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.cake),
                  onPressed: () => _showNewPanel(),
                  label: Text('nouveau')),              
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  label: Text('logout')),
              FlatButton.icon(
                  icon: Icon(Icons.settings),
                  onPressed: () => _showSettingsPanel(),
                  label: Text('settings'))
            ],
            */
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/coffee_bg.png'),
                      fit: BoxFit.cover)),
             // child: TacheList())),
             child: new Attempt(),
          ),
      ),
    );
  }
}

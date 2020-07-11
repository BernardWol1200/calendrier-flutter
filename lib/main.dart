import 'package:calendrier/main_copy.dart';
import 'package:calendrier/screens/home/screendata_One.dart';
import 'package:calendrier/screens/home/tache_detail.dart';
import 'package:calendrier/screens/wrapper.dart';
import 'package:calendrier/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value:AuthService().user, 
        child: MaterialApp(
        home: Wrapper(),
        routes: <String, WidgetBuilder>{
          "/TacheDetail":(BuildContext context) => new TacheDetail() ,
          "/ScreenOne"  : (BuildContext context) => new Attempt() ,
        },     
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:calendrier/models/tache.dart';
import 'tache_detail.dart';
import 'package:flutter/material.dart';

class TacheTile extends StatelessWidget {
  final Tache tache;
  TacheTile({this.tache});

  @override
  Widget build(BuildContext context) {

   void _showTacheDetails(String pParam, String pParam2) { 
     print('param caught $pParam');
      Navigator.of(context).pushNamed("/TacheDetail", arguments: {
        'parametre':pParam, 'parametre2':pParam2,
      });
    }

    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
        /*routes: <String, WidgetBuilder>{
          "/TacheDetail":(BuildContext context) => new TacheDetail()
           OnPressed:(){Navigator.of(context).pushNamed("/TacheDetail");}
        },          */
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
                radius: 25.0, 
                backgroundColor: Colors.brown[tache.importance],
                backgroundImage: AssetImage('assets/coffee_icon.png'),
                ),
                title:Text(tache.nom),
                subtitle: Text('Takes ${tache.details} sugar(s) uis : ${tache.laCle}'),
                onTap: () {
                  
                  _showTacheDetails(tache.laCle, tache.nom);
/*                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => YourNewPage(),
                        ),
                  ); */
                },
          ),
        ));
  }
}

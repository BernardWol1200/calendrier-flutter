import 'package:calendrier/models/tache.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'tache_tile.dart';

class TacheList extends StatefulWidget {
  @override
  _TacheListState createState() => _TacheListState();
}

class _TacheListState extends State<TacheList> {
  @override
  Widget build(BuildContext context) {
    final tachesa = Provider.of<List<Tache>>(context) ?? [];
    /*taches.forEach((tache) {
      print(tache.name);
    });
    //print(taches);
    for (var doc in taches.documents) {
      print(doc.data);
    }*/
    return ListView.builder(itemCount: tachesa.length, itemBuilder: (context, index){
      return TacheTile(tache: tachesa[index]);
    });
  }
}

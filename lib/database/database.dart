import 'package:calendrier/models/tache.dart';
import 'package:calendrier/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Collection Reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  final CollectionReference tacheCollection =
      Firestore.instance.collection('brews');

//brew list from snpshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          details: doc.data['details'] ?? '',
          uid : doc.data['uid'] ?? '',
          laCle: doc.documentID);
    }).toList();
  }      
///////////----------------------------------------------------------////////////////      
////////////-----juste les streams
///////////----------------------------------------------------------////////////////
//user data from snapshot
  Brew _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Brew(
        uid: snapshot.documentID,
        name: snapshot.data['name'],
        strength: snapshot.data['strength'],
        details: snapshot.data['details']);
  }
//get brews stream
  Stream<List<Brew>> get brewsb {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
  //-------------------------------------------------
  /*  Stream<QuerySnapshot> get taches {
    return tacheCollection.snapshots();
  }   */
  //-------------------------------------------------
  //get user doc stram
  Stream<Brew> get userData {
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
/*----------------------------------------------------------------------*/

  //get tache doc stram
  Stream<Tache> get uneTache {
    return tacheCollection.document(uid).snapshots()
    .map(_uneTacheFromSnapshot);
  }

  Tache _uneTacheFromSnapshot(DocumentSnapshot snapshot) {
    return Tache(
        uid: snapshot.documentID,
        nom: snapshot.data['name'],
        importance: snapshot.data['importance'],
        details: snapshot.data['details']);
  }  

}
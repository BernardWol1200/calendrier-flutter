
import 'package:calendrier/models/brew.dart';
import 'package:calendrier/models/tache.dart';
import 'package:calendrier/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Collection Reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  final CollectionReference tacheCollection =
      Firestore.instance.collection('taches');

  Future updateUserTache(
      String name, String details, int importance, DateTime prochDate, String user, String docId) async {
        print('docId : '+docId + ',name : '+name + ',importance : '+ importance.toString()  + ',user : '+user + ',prochDate : '+prochDate.toString());
    return await tacheCollection.document(docId).updateData({
      'nom': name,
      'details': details,            
      'importance': importance,
      'prochDate': prochDate,
      'user': user,
      'uid': uid
    });
  }

  Future insertUserData(
      String name, String details, int importance, DateTime prochDate, String user) async {
        print('insertUserData');
    return await tacheCollection.document().setData({
      'nom': name,
      'details': details,      
      'importance': importance,
      'prochDate': prochDate,
      'user': user,
      'uid': uid
    });
  }
  
  //brew list from snapshot
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

//brew list from snapshot
  List<Tache> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Tache(
          nom: doc.data['nom'] ?? '',
          importance: doc.data['importance'] ?? 0,
          details: doc.data['details'] ?? '',
          uid : doc.data['uid'] ?? '',
          laCle: doc.documentID);
    }).toList();
  }

//user data from snapshot
  Tache _listDataFromSnapshot(DocumentSnapshot snapshot) {
    return Tache(
        uid: snapshot.documentID,
        nom: snapshot.data['nom'],
        importance: snapshot.data['importance'],
        details: snapshot.data['details']);
  }

//user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: snapshot.documentID,
        name: snapshot.data['nom'],
        importance: snapshot.data['importance'],
        details: snapshot.data['details']);
  }

//get task stream
  Stream<List<Tache>> get taskb {
    return tacheCollection.snapshots().map(_taskListFromSnapshot);
  }

//get brews stream
  Stream<List<Brew>> get brewsb {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
  /*
  Stream<QuerySnapshot> get taches {
    return tacheCollection.snapshots();
  }
  */

  //get user doc stram
  Stream<UserData> get userData {
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
        nom: snapshot.data['nom'],
        importance: snapshot.data['importance'],
        details: snapshot.data['details']);
  }    

}

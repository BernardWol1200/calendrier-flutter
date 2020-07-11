import 'package:calendrier/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:calendrier/models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // auth changes stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user)=>  _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);  
  }

  //sign in anon
  Future singInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }
  //sign in email-pssw
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //register email-pssw
  Future registerWIthEmailAndPassword (String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //Create a new document for the user with the uid
      await DatabaseService(uid:user.uid).insertUserData('Bienvenue', 'Votre premiere tache', 2, DateTime.now(), user.uid);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut(); 
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew_brew_pref/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crew_brew_pref/models/brew.dart';

class DatabaseService {

  late final String uid;
  DatabaseService({ required this.uid});


  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async{
    return await brewCollection.doc(uid).set({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength
    });
  }

  // brew list from snapshot
  List<Brew>? _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name') ?? '',
        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugars') ?? '0'
      );
    }).toList();
  }

  // userData from snapshot
  UserDaeta _userDaetaFromSnapshot(DocumentSnapshot snapshot) {
    return UserDaeta(
        uid: uid,
        name: snapshot['name'],
        sugars: snapshot['sugars'],
        strength: snapshot['strength']
    );
  }

  // get brews stream
Stream<List<Brew>?> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
}

  // get user doc stream
Stream<UserDaeta> get userData  {
    return brewCollection.doc(uid).snapshots()
    .map(_userDaetaFromSnapshot);
}

}
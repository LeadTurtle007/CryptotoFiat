import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class CrudMethods {
  String datavalue;

  Future<void> addTracker(crypto, fiat) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference =
          Firestore.instance.collection('Tracker').document();

      await reference.setData(
          {"crypto": crypto, "fiat": fiat, "userID": firebaseUser.uid});
    });
  }

  Future getTracker() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance
        .collection('Tracker')
        .where('userID', isEqualTo: firebaseUser.uid)
        .getDocuments();
  }

  Future<void> addUserDetails(fname, lname) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference =
          Firestore.instance.collection('userDetails').document();

      await reference.setData(
          {"fname": fname, "lname": lname, "userID": firebaseUser.uid});
    });
  }

  Future getUserDetails() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance
        .collection('userDetails')
        .where('userID', isEqualTo: firebaseUser.uid)
        .getDocuments();
  }

  Future<void> addtrackertime() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference =
          Firestore.instance.collection('TracketTme').document();

      await reference.setData(
          {"time": "5", "frame": "seconds", "userID": firebaseUser.uid});
    });
  }

  Future gettrackertime() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return await Firestore.instance
        .collection('TracketTme')
        .where('userID', isEqualTo: firebaseUser.uid)
        .getDocuments();
  }

  Future updatetrackertime(newValues, documentID) async {
    return await Firestore.instance
        .collection('TracketTme')
        .document(documentID)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  Future deleteTracker(selectedDoc) async {
    return await Firestore.instance
        .collection('Tracker')
        .document(selectedDoc)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}

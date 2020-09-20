import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoapp/services/apiServices.dart';
import 'package:flutter/material.dart';

import 'database/crud.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List data;
  List userData;
  QuerySnapshot service;
  CrudMethods crudobj = CrudMethods();
  int cryptocount = 0;
  int fiatcount = 0;
  var cryptoname = new List();
  var fiatname = new List();

  getCrypto() async {
    data = await APIService.instance.check();
    if (data != null) {
      setState(() {
        userData = data;
        print(userData.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  _body() {
    getCrypto();
    if (userData != null) {
      print(userData.length.toString());
      for (int i = 0; i < userData.length; i++) {
        if (userData[i]['type_is_crypto'].toString() == "1") {
          // cryptoname[cryptocount] = userData[i]['asset_id'].toString();
          cryptocount++;
        } else if (userData[i]['type_is_crypto'].toString() == "0") {
          //    fiatname[fiatcount] = userData[i]['asset_id'].toString();
          fiatcount++;
        }
      }
      print(cryptocount.toString());
      print(fiatcount.toString());
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: userData.length,
            itemBuilder: (BuildContext context, int i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("data")],
              );
            }),
      );
    } else
      return _loading();
  }

  _loading() {
    return Center(
      child: Container(
          height: 50.0,
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ))),
    );
  }
}

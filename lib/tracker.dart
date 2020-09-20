import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoapp/services/apiServices.dart';
import 'package:flutter/material.dart';
import 'database/crud.dart';

class Tracker extends StatefulWidget {
  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  Map data;
  Map userData;
  QuerySnapshot service;
  QuerySnapshot service1;
  CrudMethods crudobj = CrudMethods();
  var httpDatafiat = List(1000);
  var httpDatacrypto = List(1000);
  int count = 0;
  bool first = true;

  getData() async {
    print(service.documents.length.toString());
    for (int j = 0; j < service.documents.length; j++) {
      Map data = await APIService.instance.fetchData(
          crypto: service.documents[j].data['crypto'].toString(),
          fiat: service.documents[j].data['fiat'].toString());
      if (data != null) {
        setState(() {
          userData = data;
          print(userData.toString());
          if (userData != null) {
            httpDatafiat[j] = userData['rate'];
            print(httpDatafiat[j]);
          }
        });
      }
    }
  }

  @override
  void initState() {
    crudobj.getTracker().then((value) {
      setState(() {
        service = value;
      });
    });
    crudobj.gettrackertime().then((value) {
      setState(() {
        service1 = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _calldata(5, "seconds");
    super.dispose();
  }

  _calldata(int t, String f) {
    if (first == true) {
      f = "seconds";
      t = 5;
      first = false;
    }
    switch (f) {
      case "seconds":
        {
          Timer.periodic(Duration(seconds: t), (Timer t) => getData());
        }
        break;
      case "minutes":
        {
          Timer.periodic(Duration(minutes: t), (Timer t) => getData());
        }
        break;
      case "hours":
        {
          Timer.periodic(Duration(hours: t), (Timer t) => getData());
        }
        break;
      case "days":
        {
          Timer.periodic(Duration(days: t), (Timer t) => getData());
        }
        break;
      default:
        {
          Timer.periodic(Duration(seconds: 5), (Timer t) => getData());
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    if ((service != null) && (service1 != null)) {
      if (service.documents.length > 0) {
        int t = int.parse(service1.documents[0].data['time']);
        String f = service1.documents[0].data['frame'];
        _calldata(t, f);
        // getData();
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: service.documents.length,
                itemBuilder: (BuildContext context, int i) {
                  if (userData != null) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 6.0,
                          shadowColor: Colors.black,
                          child: InkWell(
                            onLongPress: () {
                              setState(() {
                                _showAlertDialog(
                                    service.documents[i].documentID);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.black87, Colors.black]),
                                  borderRadius: BorderRadius.circular(20)),
                              height: MediaQuery.of(context).size.width / 3.61,
                              child: (Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        service.documents[i].data['crypto']
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 27,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Material(
                                    elevation: 9.0,
                                    shadowColor: Colors.black45,
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.antiAlias,
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.arrow_forward,
                                          color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        service.documents[i].data['fiat']
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 27,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      httpDatafiat[i] != null
                                          ? Text(
                                              httpDatafiat[i]
                                                  .toStringAsFixed(3),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          : _smallLoading(),
                                    ],
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else
                    return _smallLoading();
                }));
      } else
        return Center(
          child: Text(
            'No data added yet.',
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
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

  _smallLoading() {
    return Center(
      child: Container(
          height: 50.0,
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Center(
              child: Container(
            width: MediaQuery.of(context).size.width / 1.985,
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black38),
              backgroundColor: Colors.white12,
            ),
          ))),
    );
  }

  void _showAlertDialog(docID) {
    AlertDialog alertDialog1 = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(
        'Wait!',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'),
      ),
      content: Container(
        height: MediaQuery.of(context).size.width / 2.65,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Do you really want to delete this exchange rate?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 3.97,
                    height: 40,
                    child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)),
                        elevation: 7.0,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        onPressed: () {
                          crudobj.deleteTracker(docID);
                          crudobj.getTracker().then((value) {
                            setState(() {
                              service = value;
                            });
                          });
                          Navigator.pop(context);
                        }),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3.97,
                    height: 40,
                    child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)),
                        elevation: 7.0,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'No',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (_) => alertDialog1);
  }
}

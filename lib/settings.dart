import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database/auth.dart';
import 'database/crud.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class Item {
  const Item(this.name);
  final String name;
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  QuerySnapshot service;
  CrudMethods crudobj = CrudMethods();
  List<Item> users = <Item>[
    Item("seconds"),
    Item("minutes"),
    Item("hours"),
    Item("days")
  ];
  Item selectedUser;
  int timevalue;
  @override
  void initState() {
    crudobj.gettrackertime().then((value) {
      setState(() {
        service = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (service != null) {
      return Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _auth.signOut();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: Material(
                      elevation: 6.0,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Colors.black,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Current Timeframe : ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                    service.documents[0].data['time'].toString() +
                        " " +
                        service.documents[0].data['frame'].toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w900)),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 6.0,
              shadowColor: Colors.black54,
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.black87,
                      Colors.black,
                    ]),
                    borderRadius: BorderRadius.circular(20)),
                height: MediaQuery.of(context).size.width / 3.0538,
                child: (Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose Timeframe',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DelayedDisplay(
                          delay: Duration(seconds: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.836,
                                  height: 44,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  margin: EdgeInsets.only(bottom: 4, top: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    onChanged: (val) {
                                      setState(
                                          () => timevalue = int.parse(val));
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Add Interval',
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          color: Colors.black54),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              dropdown(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )),
              ),
            ),
          ),
        ],
      );
    } else
      return _loading();
  }

  Widget dropdown() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.836,
      height: 50,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(7.0)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
            child: DropdownButton<Item>(
              elevation: 6,
              underline: Container(
                color: Colors.transparent,
              ),
              icon: Icon(
                Icons.watch_later,
                color: Colors.amber,
              ),
              isExpanded: true,
              hint: Text(
                "Timeframe",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              value: selectedUser,
              onChanged: (Item value) {
                setState(() {
                  selectedUser = value;
                });
                _showAlertDialog();
              },
              items: users.map((Item user_) {
                return DropdownMenuItem<Item>(
                    value: user_,
                    onTap: () {
                      setState(() {
                        //  tapcolor = true;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      child: Text(
                        user_.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ));
              }).toList(),
            ),
          ),
        ),
      ),
    );
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

  void _showAlertDialog() {
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
        height: 150,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Do you really want to change time frame of tracker page?',
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
                    width: 100,
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
                          crudobj.updatetrackertime({
                            "time": timevalue.toString(),
                            "frame": selectedUser.name.toString()
                          }, service.documents[0].documentID);
                          crudobj.gettrackertime().then((value) {
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
                    width: 100,
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

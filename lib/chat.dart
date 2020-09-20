import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoapp/services/apiServices.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import 'database/crud.dart';
import 'homepage.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  CrudMethods crudobj = CrudMethods();
  QuerySnapshot service;
  bool yes = false;
  bool no = false;
  bool yes1 = false;
  bool no1 = false;
  String crypto = '';
  String fiat = '';
  int data;
  int ok = -1;
  @override
  void initState() {
    crudobj.getUserDetails().then((value) {
      setState(() {
        service = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getData(String cryp, String fiat) async {
    data = await APIService.instance.checkData(crypto: cryp, fiat: fiat);
  }

  @override
  Widget build(BuildContext context) {
    if (service != null) {
      String fname = service.documents[0].data['fname'];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 40,
            ),
            DelayedDisplay(
              delay: Duration(seconds: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _chatWindow("Hi " + fname + "!", Colors.black, Colors.white)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DelayedDisplay(
              delay: Duration(seconds: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _chatWindow("Do you want to add a new currency?",
                      Colors.black, Colors.white)
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DelayedDisplay(
                  delay: Duration(seconds: 4),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        yes = true;
                        no = false;
                      });
                    },
                    child: _chatWindow("Yes", Colors.greenAccent, Colors.white),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                DelayedDisplay(
                  delay: Duration(seconds: 4),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        no = true;
                        yes = false;
                        Timer.periodic(
                            Duration(seconds: 3),
                            (Timer t) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage())));
                      });
                    },
                    child: _chatWindow("No", Colors.redAccent, Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            yes == true
                ? DelayedDisplay(
                    delay: Duration(seconds: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _chatWindow(
                            "Please choose your \nCrypto currency code.",
                            Colors.black,
                            Colors.white)
                      ],
                    ),
                  )
                : Container(),
            no == true
                ? DelayedDisplay(
                    delay: Duration(seconds: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _chatWindow(
                            "Ok, thank you!", Colors.black, Colors.white)
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            yes == true
                ? DelayedDisplay(
                    delay: Duration(seconds: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.985,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            margin: EdgeInsets.only(bottom: 4, top: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              onChanged: (val) {
                                setState(() => crypto = val.toUpperCase());
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.monetization_on,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                labelText: 'Crypto Code',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    color: Colors.black38),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            (yes == true) && (crypto != '')
                ? DelayedDisplay(
                    delay: Duration(seconds: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _chatWindow(
                            "Please choose your Fiat currency code.\nIn which you want exchange rate.",
                            Colors.black,
                            Colors.white)
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            (yes == true) && (crypto != '')
                ? DelayedDisplay(
                    delay: Duration(seconds: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.985,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            margin: EdgeInsets.only(bottom: 4, top: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              onChanged: (val) {
                                setState(() => fiat = val.toUpperCase());
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.donut_small,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                labelText: 'Fiat Code',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    color: Colors.black38),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            (yes == true) && (crypto != "") && (fiat != "")
                ? DelayedDisplay(
                    delay: Duration(seconds: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _chatWindow(
                            "So do you want to add " +
                                crypto +
                                " to " +
                                fiat +
                                " \ninto your tracker page?",
                            Colors.black,
                            Colors.white)
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            (yes == true) && (fiat != '') && (crypto != '')
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DelayedDisplay(
                        delay: Duration(seconds: 6),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              yes1 = true;
                              no1 = false;
                              getData(crypto, fiat);
                              if (data != null) {
                                if (data == 1) {
                                  ok = 1;
                                  crudobj.addTracker(crypto, fiat);
                                  Timer.periodic(
                                      Duration(seconds: 3),
                                      (Timer t) => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage())));
                                } else if (data == 0) {
                                  ok = 0;
                                }
                              }
                            });
                          },
                          child: _chatWindow(
                              "Yes", Colors.greenAccent, Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      DelayedDisplay(
                        delay: Duration(seconds: 6),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              no1 = true;
                              yes1 = false;
                            });
                          },
                          child:
                              _chatWindow("No", Colors.redAccent, Colors.white),
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            (yes1 == true) &&
                    (yes == true) &&
                    (ok == 1) &&
                    (crypto != "") &&
                    (fiat != "")
                ? DelayedDisplay(
                    delay: Duration(seconds: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _chatWindow(
                            "Your Exchange rate is added \non your Tracker Page.",
                            Colors.black,
                            Colors.white)
                      ],
                    ),
                  )
                : Container(),
            (yes1 == true) &&
                    (yes == true) &&
                    (ok == 0) &&
                    (crypto != "") &&
                    (fiat != "")
                ? DelayedDisplay(
                    delay: Duration(seconds: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _chatWindow("We cannot calculate your exchange rate.",
                            Colors.black, Colors.white)
                      ],
                    ),
                  )
                : Container(),
            (no1 == true) &&
                    (yes == true) &&
                    (ok == -1) &&
                    (crypto != "") &&
                    (fiat != "")
                ? DelayedDisplay(
                    delay: Duration(seconds: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _chatWindow("Rate is not added on tracker Page",
                            Colors.black, Colors.white)
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 60,
            ),
          ],
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

  _chatWindow(String msg, Color boxClr, Color txtClr) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        margin: EdgeInsets.only(right: 12, top: 8),
        decoration: BoxDecoration(
          color: boxClr,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          msg,
          style: TextStyle(color: txtClr, fontSize: 16),
        ),
      ),
    );
  }
}

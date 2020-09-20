import 'package:cryptoapp/authenticate/afterResetSignin.dart';
import 'package:cryptoapp/database/auth.dart';
import 'package:flutter/material.dart';

class ResetByEmail extends StatefulWidget {
  @override
  _ResetByEmailState createState() => _ResetByEmailState();
}

class _ResetByEmailState extends State<ResetByEmail> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String error = '';
  String validate = '';
  String validatepass = '';
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
              child: Text('EMAIL ID',
                  style:
                      TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple))),
                        ),
                        SizedBox(height: 40.0),
                        RaisedButton(
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 7.0,
                            color: Colors.deepPurple,
                            child: Center(
                              child: Text(
                                'RESET',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var result =
                                    await _auth.resetPasswordEmail(email);
                                print(result);
                                if (result == 1) {
                                  setState(() {
                                    error =
                                        'Your Email ID is not registered. Please enter correct email ID or registered yourself.';
                                    _showAlertDialog(error);
                                  });
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AfterSignIn()));
                                }
                              }
                            }),
                        SizedBox(height: 20.0),
                      ],
                    ))),
            SizedBox(height: 15.0),
          ],
        ));
  }

  void _showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(
        'Error',
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'),
      ),
      content: Text(
        error,
        style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'),
      ),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}

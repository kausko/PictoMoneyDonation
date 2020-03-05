import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'sign_in.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'donationhistory.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreen createState() => _FirstScreen();
}

class _FirstScreen extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();

  String yearDropDown = 'FE';
  String divDropDown = '1';
  String username = 'pictomailer@gmail.com';
  String password = 'pictoTEST123';
  final databaseReference = FirebaseDatabase.instance.reference();

  TextEditingController controllerName, controllerAmount, controllerEmail;
  @override
  void initState() {
    super.initState();
    controllerName = TextEditingController();
    controllerAmount = TextEditingController();
    controllerEmail = TextEditingController();
    // if(netCntr == 0){
    //   databaseReference.child(name).update({
    //     'NetCollection': netCntr.toString()
    //   });
    // }
    getDataFunc(netCntr);
    getDataFunc(netCntr);
    getDataFunc(netCntr);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(FontAwesomeIcons.signOutAlt),
              onPressed: () => Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator
                      .defaultRouteName)) //() => Navigator.of(context).pop(null),
              ),
        ],
        leading: new Container(
            child: Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              imageUrl,
            ),
            backgroundColor: Colors.transparent,
          ),
        )),
      ),
      body: Container(
          color: Colors.grey[850],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 25),
                  Text('You have collected'),
                  Text('₹' + netCntr.toString(),
                      style: TextStyle(fontSize: 40, color: Colors.white)),
                  SizedBox(height: 50),
                  SizedBox(
                    //child: MyCustomForm(),
                    child: Form(
                        key: _formKey,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Enter Donor Name: ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextFormField(
                                controller: controllerName,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter donor name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25),
                              Text(
                                "Enter Email: ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextFormField(
                                controller: controllerEmail,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Year",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      DropdownButton<String>(
                                        value: yearDropDown,
                                        icon: Icon(FontAwesomeIcons.caretDown),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            yearDropDown = newValue;
                                          });
                                        },
                                        items: <String>['FE', 'SE', 'TE', 'BE']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Division",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      DropdownButton<String>(
                                        value: divDropDown,
                                        icon: Icon(FontAwesomeIcons.caretDown),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.white),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.blue,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            divDropDown = newValue;
                                          });
                                        },
                                        items: <String>[
                                          '1',
                                          '2',
                                          '3',
                                          '4',
                                          '5',
                                          '6',
                                          '7',
                                          '8',
                                          '9',
                                          '10',
                                          '11'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text("Amount",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      SizedBox(
                                          child: TextFormField(
                                            controller: controllerAmount,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Enter amount';
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                          ),
                                          width: 60)
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30.0),
                                child: Builder(
                                  builder: (context) => OutlineButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    highlightElevation: 0,
                                    borderSide: BorderSide(color: Colors.blue),
                                    splashColor: Colors.white,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        setDataFunc();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Submit',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    width: 300,
                  ),
                ],
              )
            ],
          )),
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.edit), title: new Text("Form")),
          new BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.rupeeSign),
              title: new Text("Donations")),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ListDataPage()));
    }
  }

  void getDataFunc(int netCntr) async {
    databaseReference.child(name).once().then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> map = Map.from(snapshot.value);
      if (snapshot.value != null) {
        setState(() {
          netCntr = int.parse(map["NetCollection"]);
          if (netCntr == null) {
            netCntr = 0;
          }
        });
      }
    });
  }

  void setDataFunc() async {
    String dname = controllerName.text;
    String yr = yearDropDown;
    int dv = int.parse(divDropDown);
    int amd = int.parse(controllerAmount.text);
    String em = controllerEmail.text;

    controllerName.clear();
    controllerAmount.clear();
    controllerEmail.clear();
    yearDropDown = 'FE';
    divDropDown = '1';

    netCntr += amd;
    print(netCntr);

    databaseReference.child(name).update({'NetCollection': netCntr.toString()});
    getDataFunc(netCntr);

    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    databaseReference.child(name).child(formattedDate).push().set({
      'Name of Donor': dname,
      'Year': yr,
      'Division': dv,
      'Amount donated': amd,
      'Email': em,
    });

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Team Pictoreal')
      ..recipients.add(em)
      ..subject = 'Thank you for your donation'
      ..text =
          'Dear $dname,\nTeam Pictoreal would like to thank you for your donation of ₹$amd. Attached below is a certificate for the same.';
    //..html = "<center><h1>Money Donation</h1>\n<h2>This certificate</h2><center>"
    //..attachments = "";

    var connection = PersistentConnection(smtpServer);
    await connection.send(message);
    await connection.close();
  }
}

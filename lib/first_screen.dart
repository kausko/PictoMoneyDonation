import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'sign_in.dart';
/*
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Adding donation to database')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
*/

class FirstScreen extends StatelessWidget {
  @override
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
            onPressed: () => Navigator.of(context).pop(null),
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
                  //Text('₹69', style: Theme.of(context).textTheme.display1)
                  Text('₹69', style: TextStyle(fontSize: 40, color: Colors.white)),
                ],
              )
            ],
          )),
    );
  }
}

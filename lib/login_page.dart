import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'sign_in.dart';

import 'first_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo[900],
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/logo.png"), height: 200),
              SizedBox(height: 25),
              Text(
                "Money Donation",
                style: TextStyle(fontSize: 32, color: Colors.amber[700]),
              ),
              Text(
                "Volunteer Login Platform",
                style: TextStyle(fontSize: 20, color: Colors.amber[700]),
              ),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
      /*
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: Colors.indigo[900],
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.facebook),
            title: new Text("Facebook")
          ),
          new BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.instagram),
            title: new Text("Instagram")
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.email),
            title: new Text("Email")
          
        ]
      ),
      */
    );
  }
}

class _signInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Text('Signing in', style: TextStyle(color: Colors.white),),
        ));
        signInWithGoogle().whenComplete(() {
          Scaffold.of(context).hideCurrentSnackBar();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FirstScreen();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget _signInButton() {
//     return OutlineButton(
//       splashColor: Colors.grey,
//       onPressed: () {
//         signInWithGoogle().whenComplete(() {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) {
//                 return FirstScreen();
//                 /*
//                 return StreamBuilder<FirebaseUser>(
//                   stream: FirebaseAuth.instance.onAuthStateChanged,
//                   builder: (context, snapshot) {
//                       FirebaseUser user = snapshot.data;
//                       return FirstScreen(user.uid);
//                   },
//                 );
//                 */
//               },
//             ),
//           );
//         });
//       },
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//       highlightElevation: 0,
//       borderSide: BorderSide(color: Colors.white),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 'Sign in with Google',
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
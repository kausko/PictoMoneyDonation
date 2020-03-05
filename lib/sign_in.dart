import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;
int netCntr;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  if (authResult.additionalUserInfo.isNewUser) {
    netCntr = 0;
    print(true);
  }
  else{
    print(false);
  }
  final FirebaseUser user = authResult.user;

  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  final dbref = FirebaseDatabase.instance.reference();
   if(netCntr == 0){
      dbref.child(name).update({
        'NetCollection': netCntr.toString()
      });
    }
    dbref.child(name).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = Map.from(snapshot.value);
      if (snapshot.value != null) {
          netCntr = int.parse(map["NetCollection"]);
          if(netCntr == null){
            netCntr = 0;
          }
      }
    });

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
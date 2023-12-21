import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_newapp/models/user_model.dart';
import 'package:firebase_with_newapp/utils/firebase_keys.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Image(image: AssetImage('assets/images/Pattern.png')),
          Container(
            margin: const EdgeInsets.all(12),
            child: TextButton(
              onPressed: () async {
               // final userCredential= await signInWithGoogle();
               // FirebaseFirestore.instance.collection('users').add(
               //     {
               //    'userId': userCredential.user?.uid,
               //       'username':userCredential.user?.displayname,
               //  });
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff191919),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const ListTile(
                title: Text(
                  'log in with insta',
                  style: TextStyle(
                    color: Color(0xffB2B3B2),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                subtitle: Text(
                  'omnia@gamil.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  final auth =FirebaseAuth.instance;
   await auth.signInWithCredential(credential);
   final user = auth.currentUser!;
 await FirebaseFirestore.instance.collection(CollectionNames.userCollection).doc(user.uid).set(
      UserModel(id: user.uid, name: user.displayName.toString(), photo: user.photoURL.toString()).toJson());

}

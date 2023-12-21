import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(const Duration(seconds: 3), () {
    // if (FirebaseAuth.instance.currentUser != null) {
    // Navigator.push(context, MaterialPageRoute(builder: (context){
    // return  HomePage();
    //  }));
    // }
    // else{
    //  Navigator.push(context, MaterialPageRoute(builder: (context){
    //  return  const AuthScreen();
    // }));
    // }
    // },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const AuthScreen();
        } else {
          return HomePage();
        }
      },
    );
  }
}

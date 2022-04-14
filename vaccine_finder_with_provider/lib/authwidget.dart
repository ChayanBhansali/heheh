import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_finder_with_provider/homeScreen.dart';
import 'package:vaccine_finder_with_provider/services/googleSignInService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vaccine_finder_with_provider/signinscreen.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService =
    Provider.of<Authentication>(context, listen: false);
    final auth = authService.firebaseuser();
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return home();
        }else{
          return signIn();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
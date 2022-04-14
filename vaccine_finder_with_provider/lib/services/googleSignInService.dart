import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Authentication {
  User? user;
   Future<User?> signInWithGoogle({required BuildContext context}) async {
     FirebaseAuth auth = FirebaseAuth.instance;


     final GoogleSignIn googleSignIn = GoogleSignIn();

     final GoogleSignInAccount? googleSignInAccount =
     await googleSignIn.signIn();
       if (googleSignInAccount != null) {
         final GoogleSignInAuthentication googleSignInAuthentication =
         await googleSignInAccount.authentication;

         final AuthCredential credential = GoogleAuthProvider.credential(
           accessToken: googleSignInAuthentication.accessToken,
           idToken: googleSignInAuthentication.idToken,
         );

         try {
           final UserCredential userCredential =
           await auth.signInWithCredential(credential);

           user = userCredential.user;
         } on FirebaseAuthException catch (e) {
           if (e.code == 'account-exists-with-different-credential') {
             Fluttertoast.showToast(
                 msg: 'account-exists-with-different-credential');
           }
           else if (e.code == 'invalid-credential') {
             Fluttertoast.showToast(msg: 'invalid-credential');
           }
         } catch (e) {
           Fluttertoast.showToast(msg: 'an error occurred');
         }
       }

    return user;
  }
    Future firebaseuser() async{
    return  await FirebaseAuth.instance;
    }
    Future signout() async{
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    }
}

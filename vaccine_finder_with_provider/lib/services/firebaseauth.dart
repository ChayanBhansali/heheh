import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class Use {
  const Use({required this.uid});
  final String uid;
}

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Use? _userFromFirebase(Use user) {
    return user == null ? null : Use(uid: user.uid);
  }

  Stream<Use> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
import 'package:flutter/material.dart';
import 'package:vaccine_finder_with_provider/authwidget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/googleSignInService.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Authentication>(
      create: (context) => Authentication(),
      child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: AuthWidget(),
        ),
    );
  }
}
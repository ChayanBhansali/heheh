import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_finder_with_provider/services/googleSignInService.dart';


class signIn extends StatefulWidget {
  const signIn({Key? key}) : super(key: key);

  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello There!'),
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Container(
                  child: Image.asset('assets/vaccinepic2.png',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 5),
                child: Container(
                  height: 50,
                  width: 260,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                  ),
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                        child: Icon(Icons.mail_outline,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: MaterialButton(
                          elevation: 4,
                          onPressed: () async {
                            final auth = await
                            Provider.of<Authentication>(context, listen: false);
                           final user = auth.signInWithGoogle(context: context);
                            // User? user = await Authentication.signInWithGoogle(context: context);
                            // if(user != null){
                            //   debugPrint(user.toString());
                            //
                            // }
                            print(user.toString());
                          },
                          child: Text('Sign In With Google ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.white
                            ),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

      ),

    );;
  }
}

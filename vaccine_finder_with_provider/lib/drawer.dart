import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vaccine_finder_with_provider/savedslots.dart';
import 'package:vaccine_finder_with_provider/services/googleSignInService.dart';
class Drawermain extends StatelessWidget {
  const Drawermain({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context, listen: false);
    final user = auth.user;
    String? photo = user?.photoURL;
    return  Drawer(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.indigo,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                   shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(photo!)),
                  )
                  ),
                  Padding(padding: EdgeInsets.all(2),
                    child: Text('${user?.displayName}',
                    style: TextStyle(
                      fontSize: 20,
                      color:Colors.white,
                    ),),
                  ),
                  Padding(padding: EdgeInsets.all(2),
                    child: Text('${user?.email}',
                      style: TextStyle(
                        fontSize: 15,
                        color:Colors.white,
                      ),),
                  )
                ],
              ),
            ),
            SizedBox(height: 1,),
            Container(
              decoration: BoxDecoration(
                color: Colors.indigo[100]
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder:  (context) =>
                      savedslots(),
                  )
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Saved Slots',
                  style: TextStyle(
                    fontSize: 16,
                  ),),
                ),

              ),
            )
          ],
        )
    );
  }
}

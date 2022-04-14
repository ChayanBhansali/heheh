import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_finder_with_provider/drawer.dart';
import 'package:vaccine_finder_with_provider/services/googleSignInService.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccine_finder_with_provider/slots.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController pincodecontroller = TextEditingController();
  String selectedDate = '';
  bool datePicked = false;
  List slots = [];
  late User username;
  getData() async {
    await http
        .get(Uri.parse(
        "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=" +
            pincodecontroller.text +
            "&date=" +
            selectedDate))
        .then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        slots = result['sessions'];
        print(slots);
      });
    });

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return FindSlot(slots);
    }));
  }


  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context, listen: false);
    final user = auth.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('hello ${user?.displayName}' ),
        actions: [
          IconButton(onPressed: ()async{
            auth.signout();
          },
              icon: Icon(Icons.logout)
          )
        ],

      ),
        drawer: Drawermain(),
      body: Container(
      width: MediaQuery.of(context).size.width,
    height:  MediaQuery.of(context).size.height,
    color: Colors.white,
        child: ListView(
          children: [
                Container(
                  child: Image.asset('assets/vaccinepic1.png'),
                ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 5),
              child: TextField(
                decoration: InputDecoration(
                  border:  OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: new BorderSide()
                  ),
                  label: Text('Enter Pincode'),
                ),
                controller: pincodecontroller ,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 5),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.indigo,
                ),
                child: MaterialButton(
                  elevation: 4,
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), // Refer step 1
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null)
                      setState(
                            () {
                          String formattedDate =
                          DateFormat('dd-MM-yyyy').format(picked);
                          selectedDate = formattedDate;
                          datePicked = true;
                          print(selectedDate);
                        },
                      );
                  },
                  child: Text(datePicked == false ? 'Pick Date' : selectedDate,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 5),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.indigo
                ),
                child: MaterialButton(
                  elevation: 4,

                  onPressed: () async {
                    if (datePicked && pincodecontroller.text.isNotEmpty) {
                      getData();
                    }else if (pincodecontroller.text.isNotEmpty){
                      final snackBar = SnackBar(
                        content: const Text('Select a Date First'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    }else if(pincodecontroller.text.isEmpty && !datePicked){
                      final snackBar = SnackBar(
                        content: const Text('Select the Date and enter Pincode'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else if(pincodecontroller.text.isEmpty){
                      final snackBar = SnackBar(
                        content: const Text('Enter Pincode'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text('Find Slots',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white
                    ),

                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

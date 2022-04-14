import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class savedslots extends StatefulWidget {
  const savedslots({Key? key}) : super(key: key);

  @override
  _savedslotsState createState() => _savedslotsState();
}

class _savedslotsState extends State<savedslots> {
  String? uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }
  getuid() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    setState(() {
      uid = user?.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved Slots'),

        ),
        body:  StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance
            .collection('Slot')
            .doc(uid)
            .collection('savedSlots')
            .snapshots() ,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }else{
                final doc =snapshot.data?.docs;
                return ListView.builder(
                    itemCount: doc?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              ListTile(
                                leading: IconButton(onPressed: () async{
                                  await FirebaseFirestore.instance
                                      .collection('Slot')
                                      .doc(uid)
                                      .collection('savedSlots')
                                      .doc(doc![index]['time'])
                                      .delete();

                                }, icon: Icon(Icons.delete),
                                ),
                                title: Container(
                                  child: Text(
                                    doc![index]['hospitalName']  ,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),

                              SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.yellow,
                                      ),
                                      child: Text(
                                        doc![index]['vaccinName'],
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.red,
                                      ),
                                      child: Text(
                                        "Available Vaccine: " +
                                            doc![index]['availability'],
                                        style: TextStyle(
                                          // fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                              child: Text(
                                                "Min. Age",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.grey,
                                                ),
                                              )),
                                          SizedBox(height: 5.0),
                                          Container(
                                            child: Text(
                                              doc![index]['minAge'] +
                                                  "+",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                              child: Text(
                                                "Fee Type",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.grey,
                                                ),
                                              )),
                                          SizedBox(height: 5.0),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: Colors.green,
                                            ),
                                            child: Text(
                                              doc![index]['feeType'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Address: " +doc![index]['address'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    // fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
            }
        )
    );
  }
}

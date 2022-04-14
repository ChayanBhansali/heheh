import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FindSlot extends StatefulWidget {
  final List slots;

  FindSlot(this.slots);

  @override
  _FindSlotState createState() => _FindSlotState();
}

class _FindSlotState extends State<FindSlot> {
  Icon icon = Icon(Icons.add);
  bool iconClicked = false ;

  addSlotToFirebase(int index) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user =  await auth.currentUser;
    String? uid = user?.uid ;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('Slot')
        .doc(uid)
        .collection('savedSlots')
        .doc(time.toString())
        .set({
      'hospitalName': widget.slots[index]["name"].toString(),
      'vaccinName':  widget.slots[index]["vaccine"].toString(),
      'availability': widget.slots[index]["available_capacity"].toString(),
      'minAge':  widget.slots[index]["min_age_limit"].toString() ,
      'feeType': widget.slots[index]["fee_type"].toString(),
      'address': widget.slots[index]["address"].toString(),
      'time' : time.toString(),
    });
    final snackBar = SnackBar(
      content: const Text('Slot Saved'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Find Slots'),
      ),
      body: ListView.builder(
          itemCount: widget.slots.length,
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
                      trailing:  IconButton(icon: icon,
                        onPressed: () {
                          addSlotToFirebase(index);
                        },
                      ),
                      title: Container(
                        child: Text(
                          widget.slots[index]["name"].toString(),
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
                              widget.slots[index]["vaccine"].toString(),
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
                                  widget.slots[index]["available_capacity"]
                                      .toString(),
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
                                    widget.slots[index]["min_age_limit"]
                                        .toString() +
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
                                    widget.slots[index]["fee_type"].toString(),
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
                        "Address: " + widget.slots[index]["address"].toString(),
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
          }),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/vendor/views/auth/screens/vendor_inner_screens/withdrawal_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('vendor');
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(data['storeImage']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Welcome Back ' + data['bussinessName'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: _ordersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                double totalOrder = 0.0;

                for (var orderItem in snapshot.data!.docs) {
                  totalOrder +=
                      orderItem['quantity'] * orderItem['productPrice'];
                }

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade900,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Total Earnings',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '\৳' + ' ' + totalOrder.toStringAsFixed(2),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade900,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Total Orders',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  snapshot.data!.docs.length.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return WithdrawalScreens();
                            }));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade900,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Withdraw',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            color: Colors.yellow.shade900,
          ),
        );
      },
    );
  }
}

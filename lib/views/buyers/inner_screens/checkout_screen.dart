import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/views/buyers/inner_screens/edit_profile.dart';

import 'package:ecommerceapp/views/buyers/main_screen.dart';
import 'package:ecommerceapp/views/buyers/nav_screens/payment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
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
              elevation: 0,
              backgroundColor: Colors.yellow.shade900,
              title: Text(
                'CheckOut',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: _cartProvider.getCartItem.length,
                itemBuilder: (context, index) {
                  final cartData =
                      _cartProvider.getCartItem.values.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        child: Container(
                          child: SizedBox(
                            height: 175,
                            // width: MediaQuery.of(context).size.width * 1,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                    cartData.imageUrl[0],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartData.productName,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 3),
                                      ),
                                      Text(
                                        '\৳' +
                                            ' ' +
                                            cartData.price.toStringAsFixed(2),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 3,
                                          color: Colors.yellow.shade900,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          OutlinedButton(
                                            onPressed: null,
                                            child: Text(
                                              cartData.productSize,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          OutlinedButton(
                                            onPressed: null,
                                            child: Text(
                                              cartData.quantity.toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            bottomSheet: data['address'] == ''
                ? TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EditProfileScreen(
                          userData: data,
                        );
                      })).whenComplete(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Enter Billing Address'))
                : Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: InkWell(
                      onTap: () {
                        EasyLoading.show(status: 'Placing Order');
                        _cartProvider.getCartItem.forEach(
                          (key, item) {
                            final orderId = Uuid().v4();
                            _firestore.collection('orders').doc(orderId).set({
                              'orderId': orderId,
                              'vendorId': item.vendorId,
                              'email': data['email'],
                              'phone': data['phoneNumber'],
                              'address': data['address'],
                              'buyerId': data['buyerId'],
                              'fullName': data['fullName'],
                              'buyerPhoto': data['profileImage'],
                              'productName': item.productName,
                              'productPrice': item.price,
                              'productId': item.productId,
                              'productImage': item.imageUrl,
                              'quantity': item.productQuantity,
                              'productSize': item.productSize,
                              'scheduleDate': item.scheduleDate,
                              'orderDate': DateTime.now(),
                              'accepted': false,
                            }).whenComplete(() {
                              setState(() {
                                _cartProvider.getCartItem.clear();
                              });
                            });
                            //EasyLoading.dismiss();

                            //Navigator.pushReplacement(context,
                            //    MaterialPageRoute(builder: (context) {
                            //  return PaymentScreen();
                            //}));
                          },
                        );

                        print('Place Order');
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade900,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return PaymentScreen();
                              }));
                              //showDialog(
                              //  context: context,
                              //  builder: (BuildContext context) {
                              //    return Expanded(
                              //      child: AlertDialog(
                              //        backgroundColor: const Color.fromARGB(
                              //            255, 214, 140, 74),
                              //        title: Text('Thank You'),
                              //        content: Text('Payment Successful ✅'),

                              //        //	actions: [
                              //        //	FlatButton(
                              //        //		textColor: Colors.black,
                              //        //		onPressed: () {},
                              //        //		child: Text('CANCEL'),
                              //        //	),
                              //        //	FlatButton(
                              //        //		textColor: Colors.black,
                              //        //		onPressed: () {},
                              //        //		child: Text('ACCEPT'),
                              //        //	),
                              //        //],
                              //      ),
                              //    );
                              //  },
                              //);
                            },
                            child: Center(
                              child: Text(
                                '\৳' +
                                    _cartProvider.totalPrice
                                        .toStringAsFixed(2) +
                                    '' +
                                    '  Place Order',
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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

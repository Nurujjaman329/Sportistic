import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/views/buyers/inner_screens/checkout_screen.dart';
import 'package:ecommerceapp/views/buyers/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState() {
    return PaymentScreenState();
  }
}

class PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
        backgroundColor: Colors.yellow.shade900,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Your Email Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Your Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Your Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Payment Successful')));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MainScreen();
                        })).whenComplete(() {
                          setState(() {
                            _cartProvider.getCartItem.clear();
                          });
                        });
                        ;
                        Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Padding(
                                //  padding: const EdgeInsets.only(left: 60.0),
                                //  child: Text(
                                //    'Your Shopping Cart is Empty',
                                //    style: TextStyle(
                                //      fontSize: 22,
                                //      fontWeight: FontWeight.bold,
                                //      letterSpacing: 2,
                                //    ),
                                //  ),
                                //),
                                //SizedBox(
                                //  height: 15,
                                //),
                                //Container(
                                //  height: 40,
                                //  width: MediaQuery.of(context).size.width - 40,
                                //  decoration: BoxDecoration(
                                //    color: Colors.yellow.shade900,
                                //    borderRadius: BorderRadius.circular(10),
                                //  ),
                                //  child: Center(
                                //    child: Text(
                                //      'Continue Shopping',
                                //      style: TextStyle(
                                //        fontWeight: FontWeight.bold,
                                //        fontSize: 18,
                                //        color: Colors.white,
                                //      ),
                                //    ),
                                //  ),
                                //),
                              ]),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow.shade900,
                      elevation: 5,

                      // Background color
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Submit'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          //child: InkWell(
                          //  onTap: _cartProvider.totalPrice == 0.00
                          //      ? null
                          //      : () {
                          //          Navigator.push(context,
                          //              MaterialPageRoute(builder: (context) {
                          //            return CheckOutScreen();
                          //          }));
                          //        },
                          child: Container(
                            height: 50,
                            width: 100,
                            //decoration: BoxDecoration(
                            //  color: _cartProvider.totalPrice == 0.00
                            //      ? Colors.grey
                            //      : Colors.white,
                            //  borderRadius: BorderRadius.circular(10.0),
                            //),
                            child: Center(
                              child: Text(
                                'Total ='
                                        '\৳' +
                                    _cartProvider.totalPrice.toStringAsFixed(0),
                                style: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: 3,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      //ElevatedButton(
      //  onPressed: () {
      //    if (_formKey.currentState!.validate()) {
      //      ScaffoldMessenger.of(context).showSnackBar(
      //        const SnackBar(content: Text('Processing Data')),
      //      );
      //    }
      //  },
      //  child: const Text('Submit'),
      //),
    );
  }
}

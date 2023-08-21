import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/views/buyers/inner_screens/checkout_screen.dart';
import 'package:ecommerceapp/views/buyers/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          'Cart Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _cartProvider.removeAllItem();
            },
            icon: Icon(CupertinoIcons.delete),
          ),
        ],
      ),
      body: _cartProvider.getCartItem.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItem.values.toList()[index];
                return Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Card(
                    child: SizedBox(
                      height: 175,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 100,
                            child: Image.network(
                              cartData.imageUrl[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartData.productName,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 3),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '\৳' + '' + cartData.price.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    // letterSpacing: 1,
                                    color: Colors.yellow.shade900,
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: null,
                                  child: Text(
                                    cartData.productSize,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 110,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow.shade900,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: cartData.quantity == 1
                                                ? null
                                                : () {
                                                    _cartProvider
                                                        .decrement(cartData);
                                                  },
                                            icon: Icon(
                                              CupertinoIcons.minus,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            cartData.quantity.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: cartData
                                                        .productQuantity ==
                                                    cartData.quantity
                                                ? null
                                                : () {
                                                    _cartProvider
                                                        .increment(cartData);
                                                  },
                                            icon: Icon(
                                              CupertinoIcons.plus,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _cartProvider
                                            .removeItem(cartData.productId);
                                      },
                                      icon: Icon(
                                        CupertinoIcons.cart_badge_minus,
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
                );
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Text(
                      'Your Shopping Cart is Empty',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MainScreen();
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
                          'Continue Shopping',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.totalPrice == 0.00
              ? null
              : () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return CheckOutScreen();
                  }));
                  //.whenComplete(() {
                  //  setState(() {
                  //    _cartProvider.getCartItem.clear();
                  //  });
                  //});
                },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _cartProvider.totalPrice == 0.00
                  ? Colors.grey
                  : Colors.yellow.shade900,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                '\৳' +
                    _cartProvider.totalPrice.toStringAsFixed(2) +
                    '  ' +
                    'CHECKOUT',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 3,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

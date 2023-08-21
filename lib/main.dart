import 'package:ecommerceapp/provider/cart_provider.dart';
import 'package:ecommerceapp/provider/product_provider.dart';
import 'package:ecommerceapp/vendor/views/auth/vendor_register_screen.dart';
import 'package:ecommerceapp/vendor/views/auth/vendors_auth.dart';
import 'package:ecommerceapp/views/buyers/inner_screens/checkout_screen.dart';
import 'package:ecommerceapp/views/buyers/main_screen.dart';
import 'package:ecommerceapp/views/buyers/nav_screens/account_screen.dart';
import 'package:ecommerceapp/views/buyers/nav_screens/category_screens.dart';
import 'package:ecommerceapp/views/buyers/nav_screens/payment_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as https;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Stripe.publishableKey =
  //    'pk_test_51NSiz5LaTLUABjKSEnSDFUq5I5RmbOjFp0fOMErFexM67onRFN4C1r84EYHPKDnhJpYM7YpoNDEAcpgLWK6pTcZd00QTYTJcBV';
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) {
      return ProductProvider();
    }),
    ChangeNotifierProvider(create: (_) {
      return CartProvider();
    })
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VendorAuthScreen(),
      builder: EasyLoading.init(),
    );
  }
}

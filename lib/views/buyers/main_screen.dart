import 'package:ecommerceapp/views/buyers/nav_screens/account_screen.dart';
import 'package:ecommerceapp/views/buyers/nav_screens/cart_screen.dart';
import 'package:ecommerceapp/views/buyers/nav_screens/category_screens.dart';
import 'package:ecommerceapp/views/buyers/nav_screens/home_screen.dart';
import 'package:ecommerceapp/views/buyers/nav_screens/search_screen.dart';
import 'package:ecommerceapp/views/buyers/nav_screens/store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    SearchScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromARGB(255, 119, 115, 115),
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
              ),
              label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_crop_circle_fill),
              label: "Profile"),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}

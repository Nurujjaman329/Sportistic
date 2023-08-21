//import 'package:ecommerceapp/views/buyers/nav_screens/search_screen.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

//class SearchInputWidget extends StatelessWidget {
//  const SearchInputWidget({
//    super.key,
//  });

//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.all(14.0),
//      child: ClipRRect(
//        borderRadius: BorderRadius.circular(10.0),
//        child: TextField(
//          onTap: () {
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return SearchScreen();
//            }));
//          },
//          decoration: InputDecoration(
//            fillColor: Colors.white,
//            filled: true,
//            hintText: 'Search For Products',
//            border: OutlineInputBorder(borderSide: BorderSide.none),
//            prefixIcon: Padding(
//              padding: const EdgeInsets.all(14.0),
//              child: SvgPicture.asset(
//                'assets/icons/search.svg',
//                width: 10,
//                height: 10,
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}

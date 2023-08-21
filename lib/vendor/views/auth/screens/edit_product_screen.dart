import 'package:ecommerceapp/vendor/views/auth/screens/edit_products_tabs/published_tab.dart';

import 'package:flutter/material.dart';

import 'edit_products_tabs/unpublished_tab.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.yellow.shade900,
          title: Text(
            'Manage Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Published'),
              ),
              Tab(
                child: Text('UnPublished'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PublishedTab(),
            UnPublishedTab(),
          ],
        ),
      ),
    );
  }
}

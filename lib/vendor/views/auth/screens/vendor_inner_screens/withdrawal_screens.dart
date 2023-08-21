import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WithdrawalScreens extends StatefulWidget {
  @override
  State<WithdrawalScreens> createState() => _WithdrawalScreensState();
}

class _WithdrawalScreensState extends State<WithdrawalScreens> {
  late String amount;

  late String name;

  late String mobile;

  late String bankName;

  late String bankAccountName;

  late String bankAccountNumber;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          'Withdraw',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 3,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Field must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    amount = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Name must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    name = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mobile Number must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    mobile = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bank Name must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    bankName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Bank Details',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Field must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    bankAccountName = value;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Bank Account Name',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Field must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    bankAccountNumber = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Bank Account Number',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ////STORE DATA IN CLOUD FIRESTORE

                      await _firestore
                          .collection('withdrawal')
                          .doc(Uuid().v4())
                          .set({
                        'Amount': amount,
                        'Name': name,
                        'Mobile': mobile,
                        'BankName': bankName,
                        'BankAccoutName': bankAccountName,
                        'BankAccountNumber': bankAccountNumber
                      });
                      print('True');
                    } else {
                      print('False');
                    }
                  },
                  child: Text(
                    'Get Cash',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

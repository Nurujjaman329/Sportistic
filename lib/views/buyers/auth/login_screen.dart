import 'package:ecommerceapp/controllers/auth_controllers.dart';
import 'package:ecommerceapp/utils/show_snaksBar.dart';
import 'package:ecommerceapp/views/buyers/auth/register_screen.dart';
import 'package:ecommerceapp/views/buyers/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;

  late String password;

  bool _isLoading = false;

  _loginUsers() async {
    //setState(() {
    //  _isLoading = true;
    //});
    if (_formKey.currentState!.validate()) {
      String res = await _authController.loginUsers(email, password);
      if (res == 'success') {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MainScreen();
        }));
      } else {
        setState(() {
          _isLoading = false;
        });
        return showSnack(context, res);
      }
    } else {
      return showSnack(context, 'Please fields must not be empty ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //Container(
          //  decoration: BoxDecoration(
          //    image: DecorationImage(
          //        image: NetworkImage(
          //            'https://www.shutterstock.com/shutterstock/photos/1315841180/display_1500/stock-vector-color-sport-background-football-basketball-hockey-box-baseball-tennis-vector-illustration-1315841180.jpg'),
          //        scale: .3,
          //        opacity: 130),
          //  ),
          Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Customer"s Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Email must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Email Address',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Password must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter Password', fillColor: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _loginUsers();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade900,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Login',
                            style: TextStyle(
                                letterSpacing: 5, color: Colors.white),
                          ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Need An Acount?',
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BuyerRegisterScreen()));
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

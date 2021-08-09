import 'package:amit_final_project/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:amit_final_project/network/service.dart';
import 'package:email_validator/email_validator.dart';

String REGISTRATION = "/registration";

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 100,
                  ),
                  TextFormField(
                    validator: validateName,
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: "Name", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: validateMail,
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "E-mail", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: validatePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: "Password", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: validateConfirmPassword,
                    controller: _passwordConfirmController,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return Fluttertoast.showToast(
                              msg: "Missing fields or incorrect input",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          User user = User(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text);
                          String res = await register(user);
                          if (res != null && res != "1") {
                            return Fluttertoast.showToast(
                                msg:
                                    "Successful Registration\n Now try to log in ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            return Fluttertoast.showToast(
                                msg: "The email has already been take",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                      },
                      child: Text("Sign up"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return ("enter your name");
    } else if (value.length < 3) {
      return "The name must be at least 3 characters";
    }
    return null;
  }

  String validateMail(String value) {
    if (value.isEmpty) {
      return ("enter your email");
    } else if (!EmailValidator.validate(value)) {
      return ("The email must be a valid email address");
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return ("Enter your password");
    } else if (value.length < 6) {
      return "The password must be at least 6 characters";
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return "Enter your password here again";
    } else if (value != _passwordController.text) {
      return "Passwords don't match";
    } else {
      return null;
    }
  }
}

import 'package:amit_final_project/login/registration.dart';
import 'package:amit_final_project/model/user.dart';
import 'package:amit_final_project/pages/pageManager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:amit_final_project/network/service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:amit_final_project/dialogue/dialogues.dart';

String LOGIN = "/logIn";

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                    height: 200,
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
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(style: TextStyle(fontSize: 14), children: [
                      TextSpan(
                          text: "Don't have an account here?   ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          style: TextStyle(color: Colors.blue),
                          text: "Sign up now!",
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Registration(),
                              ));
                            }),
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await Dialogues.showProgressDialogue(
                              context, "logging in ");
                          User user = User(
                              email: _emailController.text,
                              password: _passwordController.text);
                          String res = await login(user);
                          if (res != null) {
                            await Dialogues.updateProgressDialogue(
                                "please wait");
                            User x = await getUser(res);
                            await Dialogues.hideProgressDialogue();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => PageManager(
                                    user: x,
                                  ),
                                ),
                                (route) => false);
                          } else {
                            await Dialogues.updateProgressDialogue("failed");
                            await Dialogues.hideProgressDialogue();
                            return Fluttertoast.showToast(
                                msg:
                                    "Log in failed",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                      },
                      child: Text("Log in"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String validateMail(String value) {
    if (value.isEmpty) {
      return (" Enter your E-mail here");
    } else if (!EmailValidator.validate(value)) {
      return ("The email must be a valid email address");
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return ("Enter your password here");
    } else if (value.length < 6) {
      return "The password must be at least 6 characters";
    }
    return null;
  }
}

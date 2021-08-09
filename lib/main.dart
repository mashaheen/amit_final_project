import 'package:flutter/material.dart';
import 'login/registration.dart';
import 'pages/pageManager.dart';
import 'login/logIn.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: LOGIN,
    routes: {
      REGISTRATION: (context) => Registration(),
      PAGEMANAGER : (context)=>PageManager(),
      LOGIN : (context)=>LogIn(),
    },
  ));
}

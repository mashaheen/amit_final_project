import 'package:amit_final_project/login/logIn.dart';
import 'package:flutter/material.dart';

String MENU = "/menu";

class MenuPage extends StatefulWidget {
  const MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "More",
          style: TextStyle(color: Colors.blueAccent),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
            child: Text("OTHERS"),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey[400],
                  ),
                  title: Text(
                    "Rate App",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.rate_review,
                    color: Colors.blue,
                  ),
                ),
                Divider(
                  indent: 70,
                  color: Colors.grey[600],
                ),
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey[400],
                  ),
                  title: Text(
                    "Share App",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                  ),
                  leading: Icon(
                    Icons.ios_share,
                    color: Colors.blue,
                  ),
                ),
                Divider(
                  indent: 70,
                  color: Colors.grey[600],
                ),
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey[400],
                  ),
                  title: Text(
                    "Contact Us",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                  ),
                  leading: Icon(
                    Icons.quick_contacts_mail_rounded,
                    color: Colors.blue,
                  ),
                ),
                Divider(
                  indent: 70,
                  color: Colors.grey[600],
                ),
                ListTile(onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LogIn(),), (route) => false);
                },
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey[400],
                  ),
                  title: Text(
                    "Sign Out",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.blue,
                  ),
                ),
                Divider(
                  indent: 70,
                  color: Colors.grey[600],
                ),
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey[400],
                  ),
                  title: Text(
                    "Settings",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)
                  ),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

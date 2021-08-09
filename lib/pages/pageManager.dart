import 'package:flutter/material.dart';
import 'package:amit_final_project/pages/home.dart';
import 'package:amit_final_project/pages/category.dart';
import 'package:amit_final_project/pages/cart.dart';
import 'package:amit_final_project/pages/menu.dart';
import 'package:amit_final_project/model/user.dart';

String PAGEMANAGER = "/pageManager";

class PageManager extends StatefulWidget {
  final User user;

  const PageManager({Key key, this.user}) : super(key: key);

  @override
  _PageManagerState createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  int _navigationIndex;

  List<Widget> _navigationWidgets;


  PageController _ourPageController;

  @override
  void initState() {
    _navigationIndex = 0;
    _navigationWidgets = [
      HomePage(
        userToken: widget.user.token,
        i: 0,
      ),
      CategoryPage(userToken: widget.user.token),
      CartPage(
        userToken: widget.user.token,
      ),
      MenuPage()
    ];
    _ourPageController = PageController(initialPage: _navigationIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          _navigationIndex = value;
          setState(() {});
        },
        controller: _ourPageController,
        children: _navigationWidgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _navigationIndex ==0 ? Icon(
              Icons.home,color: Colors.pink[200],
            ) : Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: _navigationIndex==1 ? Icon(Icons.apps,color: Colors.red,) : Icon(Icons.apps), label: "Category"),
          BottomNavigationBarItem(icon: _navigationIndex ==2 ?  Icon(Icons.shopping_cart,color: Colors.green,) : Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
        ],
        currentIndex: _navigationIndex,

        onTap: goToPage,
      ),
    );
  }

  void goToPage(int value) {
    _navigationIndex = value;
    _ourPageController.animateToPage(value,
        duration: Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn);

    setState(() {});
  }
}

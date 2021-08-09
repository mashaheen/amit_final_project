import 'package:amit_final_project/dialogue/dialogues.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amit_final_project/network/cartService.dart';
import 'package:amit_final_project/model/cartItems.dart';
import '../model/cartItems.dart';
import '../network/cartService.dart';

String CART = "/cart";

class CartPage extends StatefulWidget {
  final String userToken;

  const CartPage({Key key, this.userToken}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<List<CartItemElement>> _itemsInCart;
  double finalPrice;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _itemsInCart = getCartItems(widget.userToken);
    finalPrice = 0.0;
    return FutureBuilder(
        future: _itemsInCart,
        builder: (context, AsyncSnapshot<List<CartItemElement>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null) {
            return Scaffold(
              appBar: AppBar(backgroundColor: Colors.grey[300],
                title: Text(""),

              ),
              body: Center(
                child: Text(
                  "Something went Wrong",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data.isEmpty) {
            return Scaffold(
              appBar: AppBar(backgroundColor: Colors.grey[300],
                title: Text(""),

              ),
              body: Center(
                child: Text(
                  "Your cart is empty",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            );
          } else {
            snapshot.data.forEach((element) {
              finalPrice = finalPrice + element.total;
            });
            return Scaffold(
              bottomSheet: Container(
                width: double.infinity,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await Dialogues.showProgressDialogue(context, "Advancing to checkout");
                          var list = await getCartItems(widget.userToken);
                          for(var element in list) {
                            await putItemInCart(
                                productId: element.product.id,
                                amountCount: 0,
                                token: widget.userToken);
                          }
                          await Dialogues.hideProgressDialogue();

                          setState(() {});
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey)),
                        child: Text("Confirm")),
                    Text(
                      "Total :$finalPrice EGP",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              appBar: AppBar(backgroundColor: Colors.grey[300],
                title: Text(""),

              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              snapshot.data[index].product.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: snapshot.data[index].product.avatar,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "occasions",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Price : ${snapshot.data[index].totalText}",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 15),
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async{
                                                  await Dialogues.showProgressDialogue(context, "Removing Item");
                                                  int amount =snapshot.data[index].amount-1 ;
                                                  String itemAdded= await putItemInCart(token: widget.userToken,amountCount: amount,productId: snapshot.data[index].product.id);
                                                  if(itemAdded != null){
                                                    await Dialogues.updateProgressDialogue("Item added");
                                                    await Dialogues.hideProgressDialogue();
                                                  }else{
                                                    await Dialogues.updateProgressDialogue("Failed to add item");
                                                    await Dialogues.hideProgressDialogue();
                                                  }
                                                  setState(() {

                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(2),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      5))),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300]),
                                              child: Center(
                                                  child: Text(
                                                      "${snapshot.data[index].amount}")),
                                            )),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async{
                                                  await Dialogues.showProgressDialogue(context, "Adding Item");
                                                  int amount =snapshot.data[index].amount+1 ;
                                                  String itemAdded= await putItemInCart(token: widget.userToken,amountCount: amount,productId: snapshot.data[index].product.id);
                                                  if(itemAdded != null){
                                                    await Dialogues.updateProgressDialogue("Item added");
                                                    await Dialogues.hideProgressDialogue();
                                                  }else{
                                                    await Dialogues.updateProgressDialogue("Failed to add item");
                                                    await Dialogues.hideProgressDialogue();
                                                  }
                                                  setState(() {

                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(2),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: snapshot.data.length),
                  ),
                  Expanded(flex: 1, child: Container())
                ],
              ),
            );
          }
        });
  }
}

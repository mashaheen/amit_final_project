import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amit_final_project/model/product.dart';
import 'package:amit_final_project/network/productService.dart';

import 'package:amit_final_project/network/cartService.dart';

import 'package:amit_final_project/pages/detailedProduct.dart';


import '../network/cartService.dart';
import 'package:amit_final_project/dialogue/dialogues.dart';

String HOME = "/home";
final String PURCHASEDMAP = "purchasedMap";

class HomePage extends StatefulWidget {
  final String userToken;
  final int i;

  const HomePage({Key key, this.i, this.userToken}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  Future<List<ProductElement>> _ourProducts;

  @override
  void initState() {
    super.initState();
    _ourProducts = fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.i == null || widget.i == 0) {
      _ourProducts = fetchAllProducts();
    } else {
      _ourProducts = fetchFilteredProducts(widget.i);
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.pink[200]),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _ourProducts,
        builder: (context, AsyncSnapshot<List<ProductElement>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return Center(
              child: Text("Something went wrong :("),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasData) {
            return Center(
              child: Text("List came back empty"),
            );
          } else {
            return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 3),
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          flex: 4,
                          child: Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailedProduct(
                                    product: snapshot.data[index],
                                  ),
                                ));
                              },
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: snapshot.data[index].avatar,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text(
                          snapshot.data[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text(
                          snapshot.data[index].name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Container(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: Colors.pink[200],
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              onTap: () async {
                                await Dialogues.showProgressDialogue(context, "Adding Item");
                                var list =await getCartItems(widget.userToken);
                                int amount =1 ;
                                for( var element in list){
                                  if(element.product.id == snapshot.data[index].id){
                                    amount = (element.amount)+1;
                                    break;
                                  }else{amount =1 ;}
                                }
                                String itemAdded= await putItemInCart(token: widget.userToken,amountCount: amount,productId: snapshot.data[index].id);
                                if(itemAdded != null){
                                  await Dialogues.updateProgressDialogue("Item added");
                                  await Dialogues.hideProgressDialogue();
                                }else{
                                  await Dialogues.updateProgressDialogue("Failed to add item");
                                  await Dialogues.hideProgressDialogue();
                                }
                              },
                            ),
                            Text(
                              "${snapshot.data[index].priceFinalText}",
                              style: TextStyle(
                                  color: Colors.pink[200], fontSize: 18),
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

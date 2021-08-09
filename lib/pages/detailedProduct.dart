import 'package:flutter/material.dart';
import 'package:amit_final_project/model/product.dart';

class DetailedProduct extends StatefulWidget {
  final ProductElement product;

  const DetailedProduct({Key key, this.product}) : super(key: key);

  @override
  _DetailedProductState createState() => _DetailedProductState();
}

class _DetailedProductState extends State<DetailedProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 400,
                    width: 400,
                    child: Image.network(widget.product.avatar)),
                SizedBox(height:20),
                Container(
                  alignment: AlignmentDirectional.topStart,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: 15, color: Colors.black),
                              children: [
                            TextSpan(
                                text: "Name : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                            TextSpan(text: "${widget.product.name}")
                          ])),
                      SizedBox(height:20 ,),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: 15, color: Colors.black),
                              children: [
                            TextSpan(
                                text: "Description : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                            TextSpan(text: "${widget.product.description}")
                          ])),
                      SizedBox(height:20 ,),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: 15, color: Colors.black),
                              children: [
                            TextSpan(
                                text: "Price: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                            TextSpan(text: "${widget.product.priceFinalText}")
                          ])),

                      //Text("Title:${widget.product.title}"),
                      //Text("Description:${widget.product.description}"),
                      //Text("Price:${widget.product.priceFinalText}"),
                    ],
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

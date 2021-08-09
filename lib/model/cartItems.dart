// To parse this JSON data, do
//
//     final cartItems = cartItemsFromJson(jsonString);

import 'dart:convert';

CartItems cartItemsFromJson(String str) => CartItems.fromJson(json.decode(str));

String cartItemsToJson(CartItems data) => json.encode(data.toJson());

class CartItems {
  CartItems({
    this.products,
  });

  List<CartItemElement> products;

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
    products: List<CartItemElement>.from(json["products"].map((x) => CartItemElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class CartItemElement {
  CartItemElement({
    this.amount,
    this.total,
    this.totalText,
    this.product,
  });

  int amount;
  double total;
  String totalText;
  ProductProduct product;

  factory CartItemElement.fromJson(Map<String, dynamic> json) => CartItemElement(
    amount: json["amount"],
    total: json["total"] == null ? 0.0 :json["total"].toDouble() ,
    totalText: json["total_text"],
    product: ProductProduct.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "total": total,
    "total_text": totalText,
    "product": product.toJson(),
  };
}

class ProductProduct {
  ProductProduct({
    this.id,
    this.name,
    this.title,
    this.categoryId,
    this.description,
    this.price,
    this.discount,
    this.discountType,
    this.currency,
    this.inStock,
    this.avatar,
    this.priceFinal,
    this.priceFinalText,
  });


  int id;
  String name;
  String title;
  int categoryId;
  String description;
  int price;
  int discount;
  String discountType;
  String currency;
  int inStock;
  String avatar;
  double priceFinal;
  String priceFinalText;


  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(

    id: json["id"] == null ? 0 : json["id"],
    name: json["name"] == null ? " " : json["name"],
    title: json["title"] == null ? " " :json["title"],
    categoryId: json["category_id"] == null ? 0 : json["category_id"],
    description: json["description"] == null ? " " : json["description"],
    price: json["price"],
    discount: json["discount"],
    discountType: json["discount_type"] == null ? " " : json["discount_type"],
    currency: json["currency"],
    inStock: json["in_stock"],
    avatar: json["avatar"],
    priceFinal: json["price_final"] == null ? 0.0 : json["price_final"].toDouble() ,
    priceFinalText: json["price_final_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "category_id": categoryId,
    "description": description,
    "price": price,
    "discount": discount,
    "discount_type": discountType,
    "currency": currency,
    "in_stock": inStock,
    "avatar": avatar,
    "price_final": priceFinal,
    "price_final_text": priceFinalText,
  };
}

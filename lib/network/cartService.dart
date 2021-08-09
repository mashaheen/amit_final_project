
import 'package:http/http.dart';
import 'package:amit_final_project/model/cartItems.dart' as cart;

Future<List<cart.CartItemElement>> getCartItems(String userToken) async {
  var url = Uri.parse("https://retail.amit-learning.com/api/user/products");
  Response response =
      await get(url, headers: {'Authorization': 'Bearer $userToken'});

  if (response.statusCode == 200) {
    cart.CartItems itemsBought = cart.cartItemsFromJson(response.body);
    return itemsBought.products;
  } else {
    return null;
  }
}

Future<String> putItemInCart(
    {int productId, int amountCount, String token}) async {
  var url = Uri.parse(
      "https://retail.amit-learning.com/api/user/products/$productId");

  Response response = await put(url, body: {"amount": "$amountCount"}, headers: {
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    return 'Item added';
  } else {
    return null;
  }
}

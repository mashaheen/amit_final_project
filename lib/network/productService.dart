import 'package:http/http.dart';
import 'package:amit_final_project/model/product.dart';


 Future<List<ProductElement>> fetchAllProducts () async{
  var url = Uri.parse("https://retail.amit-learning.com/api/products");
  Response response = await get(url);

  if(response.statusCode == 200){
   String jsonString = response.body;
    Products x = productFromJson(jsonString);
    List<ProductElement> list = x.products;
    return list;

  }else{
   print(response.statusCode);
   return null;
  }

}






Future<List<ProductElement>> fetchFilteredProducts (int i ) async{
 var url = Uri.parse("https://retail.amit-learning.com/api/categories/$i}");
 Response response = await get(url);

 if(response.statusCode == 200){
  String jsonString = response.body;
  Products x = productFromJson(jsonString);
  List<ProductElement> list = x.products;
  return list;

 }else{
  print(response.statusCode);
  return null;
 }

}
import 'package:http/http.dart';
import 'package:amit_final_project/model/category.dart';

Future<List<Category>> fetchAllCategories() async {
  var url = Uri.parse("https://retail.amit-learning.com/api/categories");
  Response response = await get(url);

  if (response.statusCode == 200) {
    String jsonString = response.body;
    Categories y = categoriesFromJson(jsonString);
    List<Category> list = y.categories;
    return list;
  } else {
    print(response.statusCode);
    return null;
  }
}

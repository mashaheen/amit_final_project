import 'package:amit_final_project/pages/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amit_final_project/model/category.dart';
import 'package:amit_final_project/network/categoryService.dart';

String CATEGORY = "/category";

class CategoryPage extends StatefulWidget {
  final String userToken;

  const CategoryPage({Key key, this.userToken}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin<CategoryPage>{
  Future<List<Category>> _categoryList;

  @override
  void initState() {
    super.initState();
    _categoryList = fetchAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
          title: Text("Category",style: TextStyle(color: Colors.blueAccent),),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _categoryList,
          builder: (context, AsyncSnapshot<List<Category>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 1, crossAxisSpacing: 1),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(
                          userToken: widget.userToken,
                          i: snapshot.data[index].id,
                        ),
                      ));
                    },
                    child: Stack(fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fill,
                          color: Colors.grey,
                          colorBlendMode: BlendMode.darken,
                          imageUrl:
                          snapshot.data[index].avatar,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        Center(
                          child: Text(
                            "${snapshot.data[index].name}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.blue, shape: BoxShape.circle),
                                child: Text(
                                  "${snapshot.data[index].id}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

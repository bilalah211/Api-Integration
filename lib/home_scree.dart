import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/ProductsModel.dart';

class HomeScree extends StatefulWidget {
  const HomeScree({Key? key}) : super(key: key);

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> {
  Future<ProductsModel> getProducts() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/a2369b12-efcf-47d2-88e1-85143cc8062c'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.7),
        body: FutureBuilder<ProductsModel>(
            future: getProducts(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .5,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .9,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                snapshot.data!.data![index].images!.length,
                                itemBuilder: (context, position) {
                                  return Container(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * .30,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot
                                                .data!
                                                .data![index]
                                                .images![position]
                                                .url
                                                .toString())),
                                      ));
                                }),
                          ),
                          Text(snapshot.data!.data![index].title.toString()),
                          Text(snapshot.data!.data![index].categories!.name
                              .toString()),
                          Text(snapshot.data!.data![index].categories!.type
                              .toString()),
                          Text(snapshot.data!.data![index].shop!.name
                              .toString()),
                          Text(snapshot.data!.data![index].subcat!.salePercent
                              .toString()),
                    Icon(snapshot.data!.data![index].inWishlist == true ? Icons
                        .favorite : Icons.favorite_outline)

                        ],
                      );
                    }

                  });
            }),
      ),
    );
  }
}

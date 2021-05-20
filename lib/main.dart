import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'newproduct.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      title:'Material',
      home: MyShop());
  }
}

class MyShop extends StatefulWidget {
  @override
  _MyShopState createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  double screenHeight, screenWidth;
  List _productList;
  String _titlecenter = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        backgroundColor: Colors.blue[800],
      ),
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Container(
            child: Column(
          children: [
            _productList == null
                ? Flexible(child: Center(child: Text("No Data")))
                : Flexible(
                    child: Center(
                        child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio:
                                (screenWidth / screenHeight) / 0.9,
                            children:
                                List.generate(_productList.length, (index) {  
                              return Padding(
                                padding: const EdgeInsets.all(7),
                                child: Card(
                                    elevation: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: screenHeight / 4.5,
                                          width: screenWidth / 1.0,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://javathree99.com/s270088/myshop/images/product/${_productList[index]['prid']}.png",
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Text(
                                                "Product ID: " +
                                                    _productList[index]['prid'],
                                                style:
                                                    TextStyle(fontFamily: 'RobotoMono', fontSize: 18))),
                                        SizedBox(height: 8),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Text(
                                                "Name: " +
                                                    _productList[index]['prname'],
                                                style:
                                                    TextStyle(fontFamily: 'RobotoMono', fontSize: 18))),
                                        SizedBox(height: 8),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Text(
                                                "Type: " +
                                                    _productList[index]['prtype'],
                                                style:
                                                    TextStyle(fontFamily: 'RobotoMono', fontSize: 18))),
                                        SizedBox(height: 8),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Text(
                                                "Price (RM): " +
                                                    _productList[index]
                                                        ['prprice'],
                                                style:
                                                    TextStyle(fontFamily: 'RobotoMono', fontSize: 18))),
                                        SizedBox(height: 8),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Text(
                                                "Quantity: " +
                                                    _productList[index]['prqty'],
                                                style:
                                                    TextStyle(fontFamily: 'RobotoMono', fontSize: 18))),
                                        SizedBox(height: 8),
                                      ],
                                    )),
                              );
                            })))),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (content) => NewProduct()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[800],
      ),
    );
  }

  void _loadProducts() {
    http.post(
        Uri.parse("http://javathree99.com/s270088/myshop/php/loadproduct.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Sorry no product available";
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        setState(() {
          print(_productList);
        });
      }
    });
  }
}
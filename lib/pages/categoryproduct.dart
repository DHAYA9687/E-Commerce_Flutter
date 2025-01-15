import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Widgets/support_widget.dart';
import 'package:e_commerce/services/database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Categoryproduct extends StatefulWidget {
  Categoryproduct({super.key, required this.category});
  String category;

  Map<String, String> map = {
    "Headphones": 'images/head.jpg',
    "Watch": 'images/phone.jpg',
    "Laptop": 'images/laptop1.jpg',
    "AirPods": 'images/Pods.jpg'
  };

  @override
  State<Categoryproduct> createState() => _CategoryproductState();
}

class _CategoryproductState extends State<Categoryproduct> {
  Stream? categoeyStream;

  getontheload() async {
    // ignore: avoid_print
    print(widget.category);
    categoeyStream = await DatabaseMethods.getProducts(widget.category);
    setState(() {
      categoeyStream = categoeyStream;
    });
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allProducts() {
    return StreamBuilder(
        stream: categoeyStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("An error occurred!"));
          } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return Center(child: Text("No results found"));
          }
          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      margin: EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            widget.map[widget.category]!,
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            ds["Name"],
                            style: AppWidget.semiBoldTextFieldStyle(),
                          ),
                          SizedBox(
                            height: 05.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                "\$" + ds["Price"],
                                style: TextStyle(
                                  color: Color(0xfffd6f3e),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Color(0xfffd6f3e),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  })
              // ignore: avoid_unnecessary_containers
              : Container(
                  child: Text("No result found"),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: Colors.black, // Adjust the color as needed
        elevation: 1, // Adds a shadow below the AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Goes back to the previous screen
          },
        ),
        title: Text(
          widget.category,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        color: Color(0xfff2f2f2),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: allProducts(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:e_commerce/Widgets/support_widget.dart';
import 'package:e_commerce/pages/categoryproduct.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List categories = [
    'images/head.jpg',
    'images/Pods.jpg',
    'images/phone.jpg',
    'images/laptop1.jpg',
  ];
  List categoryname = [
    'Headphones',
    'AirPods',
    'Watch',
    'Laptop',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey , Dhaya",
                        style: AppWidget.boldTextFieldStyle(),
                      ),
                      Text(
                        "Good Morning",
                        style: AppWidget.lightTextFieldStyle(),
                      )
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUv4efwDYARf5XR46l60ibliIEuSnj6oRFZA&s",
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search Products",
                    hintStyle: AppWidget.lightTextFieldStyle(),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        color: Color(0xfffd6f3c),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(right: 10.0),
                    height: 130.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                        color: Color(0xFFFD6F3C),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "All",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                      height: 130,
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            image: categories[index],
                            name: categoryname[index],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Products",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        color: Color(0xfffd6f3c),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(),
                height: 220,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    AllProducts(
                      image: "images/head.jpg",
                      name: "Headphone",
                      price: "\$100",
                    ),
                    AllProducts(
                      image: "images/Pods.jpg",
                      name: "Airpods",
                      price: "\$200",
                    ),
                    AllProducts(
                      image: "images/laptop3-nbg.png",
                      name: "Phone",
                      price: "\$300",
                    ),
                    AllProducts(
                      image: "images/phone2.png",
                      name: "Laptop",
                      price: "\$400",
                    ),
                    AllProducts(
                      image: "images/mouse-nbg.png",
                      name: "Mouse",
                      price: "\$300",
                    ),
                    AllProducts(
                      image: "images/laptop2.jpg",
                      name: "Laptop",
                      price: "\$500",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image, name;
  const CategoryTile({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Categoryproduct(category: name),
          ),
        )
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(right: 20.0),
        height: 100.0,
        width: 90.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 70, color: Colors.red);
                },
              ),
              SizedBox(
                height: 10,
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}

class AllProducts extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  const AllProducts(
      {super.key,
      required this.image,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      margin: EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 110,
            width: 110,
            fit: BoxFit.cover,
          ),
          Text(
            name,
            style: AppWidget.semiBoldTextFieldStyle(),
          ),
          SizedBox(
            height: 05.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
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
  }
}

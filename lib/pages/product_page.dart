import 'package:e_commerce/Widgets/support_widget.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfef5f1),
      body: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 20.0),
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button Row
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "Images/head-nbg.png",
                      height: 350,
                      width: 350,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Text("Image not Found"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ), // Add space between the back button and the image
            // Centered Image

            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "HeadPhone",
                          style: AppWidget.boldTextFieldStyle(),
                        ),
                        Text(
                          "\$ 200",
                          style: TextStyle(
                              color: Color(0xfffd6f3c),
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Details",
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "The Product is very good and it is very useful.The HeadPhones are too good like you can also listen person who is speaking slowly.But be aware shivan, he speaks very Loudly ",
                    ),
                    SizedBox(
                      height: 90.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xfffd6f3c),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

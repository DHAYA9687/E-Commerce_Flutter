// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final List<String> listitem = ["Headphones", "Tv", "Laptop", "Watch"];
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text(
            'Add Product',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload the Product Image",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: Icon(Icons.camera_alt_outlined),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Product Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Product Category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  items: listitem.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  dropdownColor: Colors.white,
                  hint: Text("Select Category"),
                  alignment: Alignment.center,
                  iconSize: 36,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              // child: ElevatedButton(
              //   onPressed: () {},
              //   child: Text(
              //     "Add Product",
              //     style: TextStyle(
              //       fontSize: 20,
              //       color: Colors.black,
              //       fontStyle: FontStyle.normal,
              //     ),
              //     selectionColor: Colors.black,
              //   ),
              // ),
              child: SizedBox(
                width: screenWidth * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality here
                    print("Add Product button pressed");
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Colors.blue), // Button background color
                    foregroundColor: WidgetStateProperty.all<Color>(
                        Colors.white), // Text color
                    elevation:
                        WidgetStateProperty.all<double>(6), // Shadow effect
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Smooth rounded corners
                      ),
                    ),
                    shadowColor: WidgetStateProperty.all<Color>(
                        Colors.black.withOpacity(0.3)), // Shadow color
                    overlayColor: WidgetStateProperty.resolveWith((states) {
                      // Ripple effect color on tap
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.blueAccent;
                      }
                      return null;
                    }),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add, // Icon to represent adding
                          size: 24,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10), // Space between icon and text
                        Text(
                          "Add Product",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing:
                                1.0, // Add some spacing between letters
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

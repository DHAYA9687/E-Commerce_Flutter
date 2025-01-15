// ignore_for_file: avoid_print

import 'dart:io';
// import 'dart:html' as html; // Required for FileReader in web
import 'dart:typed_data';
import 'package:e_commerce/services/database.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:random_string/random_string.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  String? path;
  final ImagePicker imagePic = ImagePicker();
  File? imageFile;
  TextEditingController productname = TextEditingController();
  TextEditingController productdetails = TextEditingController();
  TextEditingController productprice = TextEditingController();
  final databaseref = FirebaseDatabase.instance.ref();
  Uint8List? imageBytes; // For storing the image data as bytes
  String? imagePreview; // For previewing the image

  void showCustomSnack(BuildContext context, String message, String? err) {
    print("snack called");
    Color bgcolor = err == "success" ? Colors.green : Colors.red;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgcolor,
        duration: Duration(seconds: 2), // Adjust duration as needed
      ),
    );
  }

  // Future getImage() async {
  //   // var image = await imagePic.pickImage(source: ImageSource.gallery);
  //   final XFile? image = await imagePic.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //      html.FileReader reader = html.FileReader();
  //      reader.readAsArrayBuffer(html.File([image.path], "product_image"));
  //     reader.onLoadEnd.listen((_)){
  //     // setState(
  //     //   () {
  //     //     imageFile = File(image.path);
  //     //     path = image.path;
  //     //   },
  //     // );
  //     setState(() {
  //         _imageBytes = reader.result as Uint8List?;
  //         _imagePreview = image.path; // For optional debugging
  //       },);
  //     }
  //     print("path:$path");
  //   }
  // }

  // Future<void> _getImage() async {
  //   // Picking image
  //   final XFile? image = await imagePic.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     // Converting image to bytes for web display
  //     html.FileReader reader = html.FileReader();
  //     reader.readAsArrayBuffer(html.File([image.path], "product_image"));

  //     reader.onLoadEnd.listen((_) {
  //       setState(() {
  //         imageBytes = reader.result as Uint8List?;
  //         imagePreview = image.path; // For optional debugging
  //       });
  //     });
  //   }
  // }

// used to read the images as bytes from the user (compatible only for web env)

  Future<void> _getImage() async {
    final XFile? image = await imagePic.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        imageBytes = bytes;
        imageFile = File(image.path);
        path = image.path;
      });
    }
  }

//used to upload the details in firebasefirestorre
  void uploadItem() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (imageBytes != null) {
          // String id = randomAlphaNumeric(10);
          // final storageref =
          //     FirebaseStorage.instance.ref().child('blogImage').child(id);
          // final uploadTask = storageref.putFile(imageFile!);
          // final snapshot = await uploadTask.whenComplete(() {});
          // String downloadUrl = await snapshot.ref.getDownloadURL();
          // print("Image uploaded successfully: $downloadUrl");
          // final storageref =
          //     FirebaseStorage.instance.ref().child('productImage').child(id);
          // showCustomSnack(context, "Image uploaded Sucessfully", "sucess");
          print("there");
          Map<String, dynamic> addProducts = {
            "Name": productname.text,
            "Image": path,
            "Price": productprice.text,
            "Details": productdetails.text,
          };
          await DatabaseMethods.addProducts(addProducts, selectedValue!).then(
            (value) => {
              showCustomSnack(context,
                  "Product has been uploaded successfully!!", "success"),
              setState(() {
                imageBytes = null;
                imageFile = null;
                selectedValue = null;
                productname.text = "";
                productdetails.text = "";
                productprice.text = "";
              }),
            },
          );
          return;
        } else {
          showCustomSnack(context, "Please select an image", "error");
          return;
        }
      } on Exception catch (e) {
        print("Error uploading image: $e");
        showCustomSnack(context, "Error uploading Image", "err");
      }
    }
  }

//upload the details to mongodb
  // void uploadToMongo() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       if (imageBytes != null) {
  //         final res = await MOngoDatabase.uploadToMongo(
  //             productname.text, selectedValue!, imageFile!);
  //         if (res.statusCode == 201) {
  //           showCustomSnack(
  //               context, "Product uploaded successfully", "success");
  //         } else {
  //           showCustomSnack(context, "Failed to upload product", "error");
  //         }
  //         return;
  //       } else {
  //         showCustomSnack(
  //             context, "Please select an image and fill all fields", "error");
  //       }
  //     } on Exception catch (e) {
  //       print("Error uploading image: $e");
  //       showCustomSnack(context, "Error uploading Image", "err");
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final List<String> listitem = ["Headphones", "AirPods", "Laptop", "Watch"];
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text(
            'Add Product',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                (imageBytes == null)
                    ? Center(
                        child: GestureDetector(
                          onTap: () {
                            _getImage();
                          },
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
                      )
                    : Center(
                        child: Material(
                          elevation: 4.0,
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.memory(
                                imageBytes!,
                                fit: BoxFit.cover,
                                width: double
                                    .infinity, // Match parent's width if necessary
                                height: double
                                    .infinity, // Match parent's height if necessary
                              ),
                            ),
                          ),
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
                  child: TextFormField(
                    controller: productname,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter product name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "product name",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Product Price",
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
                  child: TextFormField(
                    controller: productprice,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter product price";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "\$ 0",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Product Details",
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
                  child: TextFormField(
                    maxLines: 5,
                    controller: productdetails,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter product Details";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter here...",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
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
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Make sure Category";
                        }
                        return null;
                      },
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
                  child: SizedBox(
                    width: screenWidth * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality here
                        uploadItem();
                        // uploadToMongo();
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
                            borderRadius: BorderRadius.circular(
                                15), // Smooth rounded corners
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
        ),
      ),
    );
  }
}

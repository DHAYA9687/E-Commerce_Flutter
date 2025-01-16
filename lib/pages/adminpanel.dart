import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Widgets/support_widget.dart';
import 'package:e_commerce/pages/Admin/home_admin.dart';
import 'package:flutter/material.dart';

class Adminpanel extends StatefulWidget {
  const Adminpanel({super.key});

  @override
  State<Adminpanel> createState() => _AdminpanelState();
}

class _AdminpanelState extends State<Adminpanel> {
  bool isPassWord = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void showCustomSnackBar(BuildContext context, String message, String? err) {
    Color bgcolor = err == "success" ? Colors.green : Colors.red;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgcolor,
        duration: Duration(seconds: 2), // Adjust duration as needed
      ),
    );
  }

  Future<void> adminLogin() async {
    if (_formkey.currentState!.validate()) {
      FirebaseFirestore.instance.collection("Admin").get().then(
        (snapshot) {
          for (var element in snapshot.docs) {
            if (element.data()["Name"] != userNameController.text.trim()) {
              showCustomSnackBar(context, "Invalid Username", "err");
            } else if (element.data()["Password"] !=
                userPasswordController.text.trim()) {
              showCustomSnackBar(context, "Invalid Password", "err");
            } else {
              showCustomSnackBar(context, "Login Successful", "success");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeAdmin(),
                ),
              );
            }
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
              left: 20.0, right: 20.0, bottom: 20, top: 50),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "Images/welcome2.png",
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
                Center(
                  child: Text(
                    "Admin Panel",
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Username",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4f5f9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: userNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the username";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Username",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Password",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4f5f9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the password";
                      }
                      return null;
                    },
                    obscureText: !isPassWord,
                    controller: userPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPassWord
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              isPassWord = !isPassWord;
                            },
                          );
                        },
                      ),
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        adminLogin();
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

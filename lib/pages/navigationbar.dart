import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce/pages/home_page.dart';
import 'package:e_commerce/pages/order.dart';
import 'package:e_commerce/pages/profile.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> pages = [];

  late HomePage homePage;
  late Profile profile;
  late Order order;
  int currentIndex = 0;
  @override
  void initState() {
    homePage = HomePage();
    profile = Profile();
    order = Order();
    pages = [HomePage(), Order(), Profile()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Color(0xfff2f2f2),
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(
            () {
              currentIndex = index;
            },
          );
        },
        items: const [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_4_outlined,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}

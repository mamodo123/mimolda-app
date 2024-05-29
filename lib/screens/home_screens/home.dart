import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../const/constants.dart';
import '../cart_screen.dart';
import '../profile_screen.dart';
import '../search_product_screen.dart';
import '../wishlist_screen.dart';
import 'home_screen.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeScreen(),
          SearchProductScreen(),
          CartScreen(),
          WishlistScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.heart),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.profile),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: textColors,
        unselectedLabelStyle: const TextStyle(color: textColors),
        onTap: _onItemTapped,
      ),
    );
  }
}
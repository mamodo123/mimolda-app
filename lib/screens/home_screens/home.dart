import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:provider/provider.dart';

import '../../const/constants.dart';
import '../cart_screen.dart';
import '../profile_screen.dart';
import '../search_product_screen.dart';
import '../wishlist_screen.dart';
import 'home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

enum Page { home, search, cart, wishlist, profile }

class _HomeState extends State<Home> {
  Page _selectedPage = Page.home;

  void _onItemTapped(int index, bool removeWish) {
    final fixedIndex = index == 3 && removeWish ? 4 : index;
    setState(() {
      _selectedPage = Page.values[fixedIndex];
    });
  }

  int _selectedIndex(bool removeWish) {
    final index = Page.values.indexOf(_selectedPage);
    if (index == 4 && removeWish) {
      setState(() {
        _selectedPage = Page.profile;
      });
      return index - 1;
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {

    final fullStore = context.watch<FullStoreNotifier>();
    final user = fullStore.user;
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex(user == null),
        children: [
          const HomeScreen(),
          const SearchProductScreen(),
          const CartScreen(),
          if (user != null) const WishlistScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(IconlyLight.home),
            label: 'Produtos',
          ),
          const BottomNavigationBarItem(
            icon: Icon(IconlyLight.search),
            label: 'Pesquisa',
          ),
          const BottomNavigationBarItem(
            icon: Icon(IconlyLight.bag),
            label: 'Carrinho',
          ),
          if (user != null)
            const BottomNavigationBarItem(
              icon: Icon(IconlyLight.heart),
              label: 'Desejos',
            ),
          const BottomNavigationBarItem(
            icon: Icon(IconlyLight.profile),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex((user == null)),
        selectedItemColor: primaryColor,
        unselectedItemColor: textColors,
        unselectedLabelStyle: const TextStyle(color: textColors),
        onTap: (index) => _onItemTapped(index, user == null),
      ),
    );
  }
}

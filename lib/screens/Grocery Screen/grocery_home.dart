import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../const/constants.dart';
import '../cart_screen.dart';
import '../profile_screen.dart';
import '../search_product_screen.dart';
import '../wishlist_screen.dart';
import 'grocery_home_screen.dart';

class GroceryHome extends StatefulWidget {
  const GroceryHome({Key? key}) : super(key: key);

  @override
  State<GroceryHome> createState() => _GroceryHomeState();
}

class _GroceryHomeState extends State<GroceryHome> {
  static const List<Widget> _widgetOptions = <Widget>[
    GroceryHomeScreen(),
    SearchProductScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];
  final iconList = <IconData>[
    FeatherIcons.home,
    FeatherIcons.search,
    FeatherIcons.heart,
    FeatherIcons.user,
  ];
  int _bottomNavIndex = 0;

  List<String> iconTitle = [
    'Home',
    'Search',
    'Wishlist',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: groceryMainColor,
        onPressed: () => const CartScreen().launch(context),
        child: const Icon(
          FontAwesomeIcons.bagShopping,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_bottomNavIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Icon(iconList[index],
                      color: _bottomNavIndex == index
                          ? groceryMainColor
                          : groceryGreyTextColor),
                  Text(
                    iconTitle[index],
                    style: kTextStyle.copyWith(
                        color: _bottomNavIndex == index
                            ? groceryMainColor
                            : groceryGreyTextColor),
                  ),
                ],
              ),
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }
}

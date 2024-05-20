import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ubereatsresturant/view/account/account.dart';
import 'package:ubereatsresturant/view/add_food_item_screen/add_food_item_screen.dart';
import 'package:ubereatsresturant/view/home/home.dart';
import 'package:ubereatsresturant/view/menu_screen/menu_screen.dart';
import 'package:ubereatsresturant/view/resturant_registration_screen/resturant_registration_screen.dart';
import 'package:ubereatsresturant/view/status_screen/status_screen.dart';

class BottomNavigationBarUberEats extends StatefulWidget {
  const BottomNavigationBarUberEats({super.key});

  @override
  State<BottomNavigationBarUberEats> createState() =>
      _BottomNavigationBarUberEatsState();
}

class _BottomNavigationBarUberEatsState
    extends State<BottomNavigationBarUberEats> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: const HomeScreen(),
          item: ItemConfig(
            icon: const FaIcon(FontAwesomeIcons.house),
            title: "Home",
          ),
        ),
        PersistentTabConfig(
          screen: const MenuScreen(),
          item: ItemConfig(
            icon: const FaIcon(FontAwesomeIcons.list),
            title: "Menu",
          ),
        ),
        PersistentTabConfig(
          screen: const StatusScreen(),
          item: ItemConfig(
            icon: const FaIcon(FontAwesomeIcons.bars),
            title: "Status",
          ),
        ),
        // PersistentTabConfig(
        //   screen: const AccountScreen(),
        //   item: ItemConfig(
        //     icon: const FaIcon(FontAwesomeIcons.person),
        //     title: "Account",
        //   ),
        // ),
        PersistentTabConfig(
          screen: const AccountScreen(),
          item: ItemConfig(
            icon: const FaIcon(FontAwesomeIcons.person),
            title: "Account",
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}

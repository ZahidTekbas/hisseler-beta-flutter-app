import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hisseler/main.dart';
import 'package:hisseler/screens/hisseDetailScreen.dart';
import 'package:hisseler/screens/portfolioScreen.dart';
import 'package:hisseler/screens/settingsScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      screens: _screens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.

      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears.

      navBarStyle: NavBarStyle.style1,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
    );
  }

  List<Widget> _screens() {
    return [
      MyHomePage(title: "Borsa Hisseleri"),
      PortfolioScreen(),
      SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Hisseler"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.dvr),
        title: ("Pörtföy"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(icon: Icon(Icons.settings),
      title: ("Ayarlar"),
      activeColor: CupertinoColors.activeBlue,
      inactiveColor: CupertinoColors.systemGrey)
    ];
  }
}

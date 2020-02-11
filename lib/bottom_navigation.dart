import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mogul/pages/auctions_page.dart';
import 'package:mogul/pages/home_page.dart';
import 'package:mogul/pages/owned_deeds_page.dart';
import 'package:mogul/pages/viewed_deeds_page.dart';
import 'package:mogul/widgets/fab_with_options.dart';

class BottomNavigation extends StatefulWidget {

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _selectedTab = 0;

  List<Widget> _tabPages = [
    HomePage(),
    ViewedDeedsPage(),
    OwnedDeedsPage(),
    AuctionsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mogul'),
        elevation: 0,
      ),
      body: Center(
        child: _tabPages.elementAt(_selectedTab),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.user),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.eye),
            title: Text('Viewed Deeds'),
          ),
          BottomNavigationBarItem(
            icon: Opacity(
              opacity: 0,
              child: Icon(LineIcons.eye,)
            ),
            title: Text('Empty'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.home),
            title: Text('Owned Deeds'),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.shopping_cart),
            title: Text('Auctions'),
          ),
        ],
        currentIndex: _selectedTab,
        onTap: _onTabTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FabWithOptions(
        fabOptions: [
          FabOption(
            icon: LineIcons.eye,
            onPressed: () {
              showModalBottomSheet(context: context, builder: (context) {
                return Container();
              });
            }
          ),
          FabOption(
              icon: LineIcons.money,
              onPressed: () {
                return Container();
              }
          ),
          FabOption(
              icon: LineIcons.user,
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context) {
                  return Container();
                });
              }
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      if (index < 2) {
        _selectedTab = index;
      } else if (index > 2) {
        _selectedTab = index - 1;
      }
    });
  }
}

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/widgets/utility/global_variable.dart';


class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: HomeScreenItem,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) {
          onPageChanged(index);
          _pageController.jumpToPage(index);
        },
        items: [
          BottomNavyBarItem(
            activeColor: Colors.red,
            icon: const Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                color: _currentIndex == 0 ? Colors.red.shade900 : Colors.black,
              ),
            ),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            activeColor: Colors.red.shade400.withOpacity(0.8),
            icon: const Icon(Icons.search),
            title: Text(
              'Search',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                color: _currentIndex == 1 ? Colors.red.shade900 : Colors.black,
              ),
            ),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            activeColor: Colors.red.shade400.withOpacity(0.8),
            icon: const Icon(Icons.add_circle),
            title: Text(
              'Add',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                color: _currentIndex == 2 ? Colors.red.shade900 : Colors.black,
              ),
            ),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            activeColor: Colors.red.shade400.withOpacity(0.8),
            icon: const Icon(Icons.favorite),
            title: Text(
              'Favorite',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                color: _currentIndex == 3 ? Colors.red.shade900 : Colors.black,
              ),
            ),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            activeColor: Colors.red.shade400.withOpacity(0.8),
            icon: const Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                color: _currentIndex == 4 ? Colors.red.shade900 : Colors.black,
              ),
            ),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

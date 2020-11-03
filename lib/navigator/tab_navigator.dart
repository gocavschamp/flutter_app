import 'package:flutter/material.dart';
import 'package:flutter_app/pages/homepage.dart';
import 'package:flutter_app/pages/mypage.dart';
import 'package:flutter_app/pages/searchpage.dart';
import 'package:flutter_app/pages/travelpage.dart';

class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  Color _defaltColor = Colors.grey;
  Color _activeColor = Colors.red;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [HomePage(), SearchPage(), TravelPage(), MyPage()],
        physics: NeverScrollableScrollPhysics(),//关闭手势滑动页面
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _defaltColor,
            ),
            activeIcon: Icon(
              Icons.home,
              color: _activeColor,
            ),
            title: Text(
              '首页',
              style: TextStyle(
                  color: _currentIndex != 0 ? _defaltColor : _activeColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _defaltColor,
            ),
            activeIcon: Icon(
              Icons.search,
              color: _activeColor,
            ),
            title: Text(
              '搜索',
              style: TextStyle(
                  color: _currentIndex != 1 ? _defaltColor : _activeColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.traffic,
              color: _defaltColor,
            ),
            activeIcon: Icon(
              Icons.traffic,
              color: _activeColor,
            ),
            title: Text(
              '旅游',
              style: TextStyle(
                  color: _currentIndex != 2 ? _defaltColor : _activeColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_contact_calendar,
              color: _defaltColor,
            ),
            activeIcon: Icon(
              Icons.perm_contact_calendar,
              color: _activeColor,
            ),
            title: Text(
              '我的',
              style: TextStyle(
                  color: _currentIndex != 3 ? _defaltColor : _activeColor),
            ),
          ),
        ],
      ),
    );
  }
}

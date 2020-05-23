import 'package:flutter/material.dart';

enum TabItem { home, map, shaky }

Map<TabItem, String> tabName = {
  TabItem.home: 'home',
  TabItem.map: 'map',
  TabItem.shaky: 'shaky',
};

class BottomNavBar extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  BottomNavBar({this.currentTab, this.onSelectTab});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(tabItem: TabItem.home),
        _buildItem(tabItem: TabItem.map),
        _buildItem(tabItem: TabItem.shaky),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = tabName[tabItem];
    IconData icon = Icons.layers;
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      title: Text(
        text,
      ),
    );
  }
}

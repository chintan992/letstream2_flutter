import 'package:flutter/material.dart';

class DetailsTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  const DetailsTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: tabs.map((name) => Tab(text: name)).toList(),
      indicatorColor: Colors.greenAccent,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
    );
  }
}

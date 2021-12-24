import 'package:flutter/material.dart';
import 'package:flutter_demo/screen/second_screen.dart';
import 'package:flutter_demo/screen/third_screen.dart';

import '../audio_player/audio_player_screen.dart';
import 'clip_exmple.dart';
import 'first_screen.dart';
import '../form_validation_screen/form_validation_screen.dart';

class MainScreen extends StatefulWidget {
  int selectedPage = 0;
  MainScreen(this.selectedPage);
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 5,initialIndex: widget.selectedPage);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    print("_tabController -->> ${_tabController.index}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
        actions: [
          Switch(
            value: isSwitch,
            onChanged: (bool value) {
              setState(() {
                isSwitch = !isSwitch;
              });
            },
          )
        ],
        bottom: TabBar(
          tabs: [
            Tab(text: "Demo1"),
            Tab(text: "Demo2"),
            Tab(text: "ChipDemo"),
            Tab(text: "AudioPlayer"),
            Tab(text: "Demo 3")
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [
          FirstScreen(isSwitch),
          SecondScreen(),
          ChipDemo(),
          AudioPlayerExample(),
          ThirdScreen(),
        ],
        controller: _tabController,
      ),
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/brand_colors.dart';
import 'package:rider_app/tabs/earningstab.dart';
import 'package:rider_app/tabs/hometab.dart';
import 'package:rider_app/tabs/profiletab.dart';
import 'package:rider_app/tabs/ratingstab.dart';

class MainPage extends StatefulWidget {

  static const String id = 'mainpage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{

  TabController tabController;
  int selectedIndex = 0;
  void onItemClicked(int index){
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
      controller: tabController,
        children: <Widget>[
          HomeTab(),
          EarningsTab(),
          RatingsTab(),
          ProfileTab(),
        ],
      ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
              title: Text('Главная')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.credit_card),
                  title: Text('Доход')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  title: Text('Рейтинг')
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Аккаунт')
              ),
            ],
            currentIndex: selectedIndex,
            unselectedItemColor: BrandColors.colorIcon,
            selectedItemColor: BrandColors.colorOrange,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(fontSize: 12),
            type: BottomNavigationBarType.fixed,
            onTap: onItemClicked,
          ),
        );

  }
}

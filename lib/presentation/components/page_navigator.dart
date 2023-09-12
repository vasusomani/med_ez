import 'package:flutter/material.dart';
import 'logout_dialog.dart';
import '../../constants/colors.dart';
import '../screen/dashboard_screen.dart';
import '../screen/profile_screen.dart';

class PagesNavigator extends StatefulWidget {
  PagesNavigator({super.key, this.mainIndex = 0});
  int mainIndex;
  @override
  State<PagesNavigator> createState() => _PagesNavigatorState();
}

class _PagesNavigatorState extends State<PagesNavigator> {
  @override
  Widget build(BuildContext context) {
    Widget currentPage =
        widget.mainIndex == 0 ? const DashboardScreen() : const ProfileScreen();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: widget.mainIndex == 0
                ? const Text("My Dashboard")
                : const Text("My Profile"),
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0.7,
            titleTextStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: buttonTextColor,
            ),
            toolbarHeight: 70,
            actions: [
              if (widget.mainIndex == 1)
                IconButton(
                    onPressed: () async {
                      showLogoutDialog(context);
                    },
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                    ))
            ],
          ),
          body: currentPage,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BottomNavigationBar(
              backgroundColor: appBarColor.withOpacity(0.8),
              selectedItemColor: bgPrimaryColor,
              selectedIconTheme: const IconThemeData(size: 35),
              unselectedItemColor: bgPrimaryColor,
              currentIndex: widget.mainIndex,
              iconSize: 30,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.space_dashboard_rounded),
                  label: "Dashboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_rounded),
                  label: "Profile",
                ),
              ],
              onTap: (value) {
                setState(() {
                  widget.mainIndex = value;
                });
              },
            ),
          )),
    );
  }
}

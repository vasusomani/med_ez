import 'dart:io';
import 'package:flutter/material.dart';
import 'package:med_ez/data/services/api_service.dart';
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
          bottomNavigationBar: Container(
            color: Colors.transparent,
            padding: (Platform.isIOS)
                ? const EdgeInsets.all(0)
                : const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: appBarColor.withOpacity(0.8),
                selectedItemColor: bgPrimaryColor,
                selectedIconTheme: const IconThemeData(size: 27),
                unselectedIconTheme:
                    const IconThemeData(size: 23, color: Colors.white70),
                unselectedItemColor: Colors.white70,
                currentIndex: widget.mainIndex,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
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
            ),
          )),
    );
  }
}

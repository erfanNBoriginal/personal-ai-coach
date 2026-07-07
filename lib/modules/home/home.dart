import 'package:flutter/material.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class HomeSell extends StatelessWidget {
  final Widget child;

  const HomeSell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
              
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: child),
             Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: U.NavigationBar(
              navItems: [
                U.NavBarItem(
                  isPrimary: true,
                  title: 'title',
                  path: U.Icons.menu,
                  onTap: () {},
                ),
                U.NavBarItem(
                  isPrimary: true,
                  title: 'title',
                  path: U.Icons.menu,
                  onTap: () {},
                ),
                U.NavBarItem(
                  isPrimary: false,
                  title: 'title',
                  path: U.Icons.menu,
                  onTap: () {},
                ),
                U.NavBarItem(
                  isPrimary: false,
                  title: 'title',
                  path: U.Icons.menu,
                  onTap: () {},
                ),
              ],
            ),
          ),
     
        ],
      ),
    );
  }
}

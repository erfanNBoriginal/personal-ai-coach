import 'package:flutter/material.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class Chat extends StatelessWidget {
  static final route = '/chat';

  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.amber, height: 122),
        
           Positioned.fill(
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
                   title: 'fuck',
                   path: U.Icons.menu,
                   onTap: () {},
                 ),
                 U.NavBarItem(
                   isPrimary: false,
                   title: 'shiiiiit',
                   path: U.Icons.menu,
                   onTap: () {},
                 ),
               ],
             ),
           ),
     
        // Container(color: Colors.amber, height: 122),
      ],
    );
  }
}

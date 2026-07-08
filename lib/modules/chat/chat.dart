import 'package:flutter/material.dart';
import 'package:personal_ai_coach/modules/chat/goal_textfield.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class ChatPge extends StatelessWidget {
  static final route = '/chat';

  const ChatPge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // backgroundColor: U.Theme.afternoonPallet,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: U.Theme.afternoonPallet.getColors,
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: U.AppBar(title: 'create')),
          SliverFillRemaining(
            hasScrollBody: false, // key: content won't scroll, just centers
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(flex: 8, child: SizedBox()),
                Column(
                  children: [
                    U.Text(
                      text: 'describe your goal!',
                      textWeight: U.TextWeight.bold,
                      textSize: U.TextSize.s18,
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GoalTextfield(),
                    ),
                  ],
                ),
                Expanded(flex: 20, child: SizedBox()),
              ],
            ),
          ),

          // SliverToBoxAdapter(child: SizedBox(height: 121,),),
        ],
      ),

      //   Stack(
      //     children: [
      //       // Container(color: Colors.amber, height: 122),
      //       Positioned.fill(
      //         child: U.NavigationBar(
      //           navItems: [
      //             U.NavBarItem(
      //               isPrimary: true,
      //               title: 'title',
      //               path: U.Icons.menu,
      //               onTap: () {},
      //             ),
      //             U.NavBarItem(
      //               isPrimary: true,
      //               title: 'title',
      //               path: U.Icons.menu,
      //               onTap: () {},
      //             ),
      //             U.NavBarItem(
      //               isPrimary: false,
      //               title: 'title',
      //               path: U.Icons.menu,
      //               onTap: () {},
      //             ),
      //             U.NavBarItem(
      //               isPrimary: false,
      //               title: 'fuck',
      //               path: U.Icons.menu,
      //               onTap: () {},
      //             ),
      //             U.NavBarItem(
      //               isPrimary: false,
      //               title: 'shiiiiit',
      //               path: U.Icons.menu,
      //               onTap: () {},
      //             ),
      //           ],
      //         ),
      //       ),

      //       // Container(color: Colors.amber, height: 122),
      //     ],
      //   ),
      // ),
    );
  }
}

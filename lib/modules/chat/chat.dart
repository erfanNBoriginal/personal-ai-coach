import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_ai_coach/domains/business_repository/business_repository.dart';
import 'package:personal_ai_coach/domains/business_repository/models/message.dart';
import 'package:personal_ai_coach/modules/chat/chat_bubble.dart';
import 'package:personal_ai_coach/modules/chat/cubit/chat_cubit.dart';
import 'package:personal_ai_coach/modules/chat/goal_textfield.dart';
import 'package:personal_ai_coach/ui_kit/ui_kit.dart' as U;

class ChatPge extends StatelessWidget {
  static final route = '/chat';

  const ChatPge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatCubit(repository: context.read<BusinessRepository>()),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return state.loading
              ? Center(child: CircularProgressIndicator())
              : state.messages.isNotEmpty
              ? Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: U.Theme.afternoonPallet.getColors,
                      begin: AlignmentGeometry.topCenter,
                      end: AlignmentGeometry.bottomCenter,
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(24),
                    children: [
                      ...state.messages.expand(
                        (e) => [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: ChatBubble(text: e.description),
                              ),
                              SizedBox(height: 19),
                              ...e.questions.expand(
                                (e) => [
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 80,
                                          child: U.OutlineButton(
                                            title: e.label,
                                            onTap: () {},
                                          ),
                                        ),
                                        Flexible(flex: 20, child: SizedBox()),
                                      ],
                                    ),
                                  ),
                              SizedBox(height: 16),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(
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
                        hasScrollBody:
                            false, // key: content won't scroll, just centers
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(flex: 8, child: SizedBox()),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final res = await context
                                        .read<ChatCubit>()
                                        .onGoalCreated(
                                          messages: [
                                            Message(
                                              role: 'user',
                                              content: 'i want to be a pianist',
                                            ),
                                          ],
                                        );
                                  },
                                  child: U.Text(
                                    text: 'describe your goal!',
                                    textWeight: U.TextWeight.bold,
                                    textSize: U.TextSize.s18,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
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
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_ai_coach/modules/chat/chat.dart';

final rootNavKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: Chat.route,
  navigatorKey: rootNavKey,

  routes: [
    GoRoute(
      path: Chat.route,
      name: Chat.route,
      builder: (context, state) => Chat(),
    ),
    // ShellRoute(
    //   builder: (context, state, child) {
    //     return HomeSell(child: child);
    //   },
    //   routes: [GoRoute(path: Chat.route, name: Chat.route,
    //   builder: (context, state) => Chat(),
    //   )],
    // ),
  ],
);

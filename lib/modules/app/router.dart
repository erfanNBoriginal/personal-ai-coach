import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_ai_coach/modules/chat/chat.dart';
import 'package:personal_ai_coach/modules/home/home.dart';
import 'package:personal_ai_coach/modules/roadmap/roadmap_page.dart';

final rootNavKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: RoadmapPage.route,
  navigatorKey: rootNavKey,

  routes: [
    // GoRoute(
    //   path: Chat.route,
    //   name: Chat.route,
    //   builder: (context, state) => Chat(),
    // ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeSell(child: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ChatPge.route,
              name: ChatPge.route,
              builder: (context, state) => ChatPge(),
            ),
            GoRoute(
              path: RoadmapPage.route,
              name: RoadmapPage.route,
              builder: (context, state) => RoadmapPage(),
            ),
          ],
        ),
      ],
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

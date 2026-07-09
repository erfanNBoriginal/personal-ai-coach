import 'package:flutter/material.dart';
import 'package:personal_ai_coach/data_providers/business_ws/business_ws.dart';
import 'package:personal_ai_coach/modules/app/router.dart';

void main() {
  BusinessWs.Init(onUnauthorized: () {}, onError: (message) {});
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

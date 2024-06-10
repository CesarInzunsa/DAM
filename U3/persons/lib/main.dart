import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './view/mobile/home_view_mobile.dart';
import './view/tablet/home_view_tablet.dart';
import './view/desktop/home_view_desktop.dart';

void main() {
  initFirebase();
  runApp(const MyApp());
}

void initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: _screenTypeLayoutBuilder(),
    );
  }

  _screenTypeLayoutBuilder() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const HomeViewMobile();
        } else if (constraints.maxWidth < 840) {
          return const HomeViewTablet();
        } else {
          return const HomeViewDesktop();
        }
      },
    );
  }
}

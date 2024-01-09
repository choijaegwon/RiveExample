import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rive_example/bird.dart';
import 'package:rive_example/lil_guy_one.dart';
import 'package:rive_example/lil_guy_two.dart';

void main() {
  runApp(
    MyApp(),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final PageController pageController = PageController(
    initialPage: 0,
  );

  // LilGuyone()
  // FloatingActionButton 버튼을 눌러서도 실행되고, 버튼을 클릭하여도 되는 버전

  // LilGuyTwo()
  // bard 안에 있는 Button을 클릭하여 동작 시키는 버전

  // Bird()
  // Toggle을 하면 춤을 추고, 버튼을 클릭하면 예정된 움직임 한번 실행되는 버전
  List<Widget> widgets = [const LilGuyone(), const LilGuyTwo(), const Bird()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return widgets[index % widgets.length];
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('다른 Version 보기')),
            ],
          ),
        ),
      ),
    );
  }
}

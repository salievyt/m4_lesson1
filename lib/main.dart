import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4_lesson1/m4/lesson2/view/counter_page.dart';
import 'package:m4_lesson1/m4/lesson2/viewmodel/counter_block.dart';

void main() {
  runApp(
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => CounterModel()),
    //     ChangeNotifierProvider(create: (_) => HmModel()),
    //   ],
    //   child: const MainApp(),
    // ),
    const MainApp()
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterBlock(),
        child: CounterPage(),
      ),
    );
  }
}

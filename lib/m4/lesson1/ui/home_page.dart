import 'package:flutter/material.dart';
import 'package:m4_lesson1/m4/lesson1/notify/counter_model.dart';
import 'package:m4_lesson1/m4/lesson1/notify/hm_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<String> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = context.read<HmModel>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterModel>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('${counter.count}'),
              // const SizedBox(height: 40),
              // ElevatedButton(
              //   onPressed: counter.increment,
              //   child: const Text('Increment'),
              // ),
              // const SizedBox(height: 40),
              FutureBuilder<String>(
                future: _loadFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }else if (snapshot.hasError) {
                    return Text('Ошибка: ${snapshot.error}');
                  }else if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } 
                  return const Text('Нет данных');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

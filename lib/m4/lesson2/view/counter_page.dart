import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4_lesson1/m4/lesson2/viewmodel/counter_block.dart';
import 'package:m4_lesson1/m4/lesson2/viewmodel/counter_event.dart';
import 'package:m4_lesson1/m4/lesson2/viewmodel/counter_state.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 16,),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBlock>().add(IncrementEvent());
              print("click");
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 46,),
          FloatingActionButton(
            onPressed: () => context.read<CounterBlock>().add(DecrementEvent()),
            child: Icon(Icons.remove),
          ),
          SizedBox(width: 16,),

        ],
      ),
      appBar: AppBar(
        title: Text("Bloc Example", style: TextStyle(fontSize: 32),),
        centerTitle: false,
      ),
      body: Center(
        child: BlocBuilder<CounterBlock, CounterState>(
          builder: (context, state) {
            print(state.model.status);
            return Column(
                children: [
                  Text("${state.model.count}"),
                  Text(state.model.status),
                ],
              );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyLatihanList());
// }

class MyLatihanList extends StatefulWidget {
  const MyLatihanList({super.key});

  @override
  State<MyLatihanList> createState() => _MyLatihanListState();
}

class _MyLatihanListState extends State<MyLatihanList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.5),
          title: const Text('Parent ListV_Builder'),
        ),
        body: const MyContainer(),
      ),
    );
  }
}

class MyContainer extends StatefulWidget {
  const MyContainer({super.key});

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Card $index'),
              ),
            );
          }),
    );
  }
}

class MyExpaded extends StatefulWidget {
  const MyExpaded({super.key});

  @override
  State<MyExpaded> createState() => _MyExpadedState();
}

class _MyExpadedState extends State<MyExpaded> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Card $index'),
              ),
            );
          }),
    );
  }
}

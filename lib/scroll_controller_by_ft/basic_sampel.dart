import 'package:flutter/material.dart';

// void main() {
//   runApp(BasicSampel());
// }

class BasicSampel extends StatelessWidget {
  BasicSampel({super.key});

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scrollcontroller Test'),
        ),
        body: ListView.builder(
          controller: _controller,
          itemCount: 20,
          itemBuilder: (context, int index) {
            return Container(
              alignment: Alignment.center,
              height: 150,
              color: index % 2 == 0
                  ? Colors.blue.shade100
                  : Colors.orange.shade100,
              child: Text(
                'Item $index',
                style: const TextStyle(fontSize: 22),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// void main() {
//   runApp(BasicSampel());
// }

class BasicSampel extends StatelessWidget {
  BasicSampel({super.key});

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      // position : Mengembalikan ScrollPosition saat ini yang digunakan oleh controller atau Mengembalikan objek ScrollPosition.
      print(_controller.position.pixels);

      // Mengembalikan offset scroll saat ini. mengembalikan nilai double

      // print(_controller.offset);
    });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Get Position'),
        ),
        body: ListView.builder(
          controller: _controller,
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              height: 120,
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

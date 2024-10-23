import 'package:flutter/material.dart';

// void main() {
//   runApp(BasicSampel());
// }

class BasicSampel extends StatelessWidget {
  BasicSampel({super.key});

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    // _controller.addListener(() {
    //   print(_controller.position.pixels);
    // });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Use method jumpTo'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                // method jumpTo : Langsung menggulir ke posisi offset tertentu tanpa animasi.
                // _controller.jumpTo(_controller.position.minScrollExtent);
                //
                // method animateTo adalah menggulirkan secara animasi ke posisi tertentu
                // _controller.animateTo(
                //   _controller.position.minScrollExtent,
                //   duration: const Duration(seconds: 2),
                //   curve: Curves.easeIn,
                // );

                _controller.animateTo(
                  _controller.offset - 120,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              child: const Icon(
                Icons.arrow_upward,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                // _controller.jumpTo(_controller.position.maxScrollExtent);
                //
                // _controller.animateTo(
                //   _controller.position.maxScrollExtent,
                //   duration: const Duration(seconds: 2),
                //   curve: Curves.easeIn,
                // );

                _controller.animateTo(
                  _controller.offset + 120,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              child: const Icon(
                Icons.arrow_downward,
              ),
            )
          ],
        ),
      ),
    );
  }
}

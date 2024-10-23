import 'package:flutter/material.dart';

void main() {
  runApp(const BasicSampel());
}

class BasicSampel extends StatefulWidget {
  const BasicSampel({super.key});

  @override
  State<BasicSampel> createState() => _BasicSampelState();
}

class _BasicSampelState extends State<BasicSampel> {
  final ScrollController _controller = ScrollController();
  String _scrollLocation = 'Paling Atas';

  @override
  void initState() {
    _controller.addListener(_listenToScrollMoment);
    super.initState();
  }

  // method ini untuk mendeteksi posisi offset dari widget yang di scroll
  void _listenToScrollMoment() {
    String currentLocatrion = '';

    if (_controller.offset == _controller.position.minScrollExtent) {
      currentLocatrion = 'Paling atas';
    } else if (_controller.offset == _controller.position.maxScrollExtent) {
      currentLocatrion = 'Paling bawah';
    } else {
      currentLocatrion = 'masih di tengah';
    }
    setState(() {
      _scrollLocation = currentLocatrion;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_scrollLocation),
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
      ),
    );
  }
}

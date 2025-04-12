import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyStrbldrMapEntry());
}

class MyStrbldrMapEntry extends StatelessWidget {
  const MyStrbldrMapEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NumberTrxtList(),
    );
  }
}

class NumberTrxtList extends StatefulWidget {
  const NumberTrxtList({super.key});

  @override
  State<NumberTrxtList> createState() => _NumberTrxtListState();
}

class _NumberTrxtListState extends State<NumberTrxtList> {
  final StreamController<List<MapEntry<int, String>>> _controller =
      StreamController<List<MapEntry<int, String>>>.broadcast();

  final List<MapEntry<int, String>> _data = [];

  void _addItem() {
    int next = _data.length + 1;
    _data.add(MapEntry(next, 'Angka $next'));
    _controller.sink.add(_data);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MapEntry StreamBuider'),
      ),
      body: StreamBuilder(
          stream: _controller.stream,
          initialData: const [],
          builder: (context, snapshot) {
            final entries = snapshot.data ?? [];
            if (entries.isEmpty) {
              return const Center(
                child: Text('Belum ada data'),
              );
            }

            return ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(entry.key.toString()),
                    ),
                    title: Text(entry.value),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}

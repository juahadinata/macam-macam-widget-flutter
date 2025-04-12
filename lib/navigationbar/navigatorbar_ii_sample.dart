///* Contoh ini menampilkan perilaku label NavigationBar.
///* Saat mengetuk salah satu opsi perilaku label,
///* perilaku label NavigationBar akan diperbarui.
///
///

import 'package:flutter/material.dart';

void main() {
  runApp(const NavigationBarDuaApp());
}

class NavigationBarDuaApp extends StatelessWidget {
  const NavigationBarDuaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavigationBarDuaExample(),
    );
  }
}

class NavigationBarDuaExample extends StatefulWidget {
  const NavigationBarDuaExample({super.key});

  @override
  State<NavigationBarDuaExample> createState() =>
      _NavigationBarDuaExampleState();
}

class _NavigationBarDuaExampleState extends State<NavigationBarDuaExample> {
  int curretPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: curretPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            curretPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.explore), label: 'Explorer'),
          NavigationDestination(icon: Icon(Icons.commute), label: 'Comute'),
          NavigationDestination(
              icon: Icon(Icons.bookmark_border), label: 'Saved'),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Label behaviour: ${labelBehavior.name}'),
            const SizedBox(height: 10),
            OverflowBar(
              spacing: 10.0,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        labelBehavior =
                            NavigationDestinationLabelBehavior.alwaysShow;
                      });
                    },
                    child: const Text('selaluTampil')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        labelBehavior =
                            NavigationDestinationLabelBehavior.onlyShowSelected;
                      });
                    },
                    child: const Text('tampilterpilih')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        labelBehavior =
                            NavigationDestinationLabelBehavior.alwaysHide;
                      });
                    },
                    child: const Text('selaluTidakTampil')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

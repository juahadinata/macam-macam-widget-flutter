import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MenuAnchor + BottomNavigationBar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of screens
  final List<Widget> _pages = [
    const PageHome(),
    const PageSearch(),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.amber,
        // leading: MenuAnchor(
        //     builder: (context, controller, child) {
        //       return IconButton(
        //           onPressed: () {
        //             if (controller.isOpen) {
        //               controller.close();
        //             } else {
        //               controller.open();
        //             }
        //           },
        //           icon: Icon(Icons.person));
        //     },
        //     menuChildren: [
        //       MenuItemButton(
        //         onPressed: () {},
        //         child: Text('Profile'),
        //       )
        //     ]),
        title: const Text('MenuAnchor + BottomNavigationBar'),
        actions: [
          MenuAnchor(
            builder: (context, controller, child) {
              return IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
              );
            },
            menuChildren: [
              MenuItemButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 2.0,
                      shape: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 3.0),
                          borderRadius: BorderRadius.circular(15)),
                      content: Text(
                        'About Selected',
                        style: TextStyle(color: Colors.indigo.shade900),
                      ),
                      backgroundColor: Colors.amber.shade200,
                      showCloseIcon: true,
                      closeIconColor: Colors.red,
                    ),
                  );
                },
                child: const Text('About'),
              ),
              MenuItemButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Help Selected')));
                },
                child: const Text('Help'),
              ),
              MenuItemButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Version Selected')));
                },
                child: const Text('Version'),
              ),
            ],
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Colors.blue,
            child: const Center(
                child: Text('Home Page', style: TextStyle(fontSize: 24)))),
      ),
    );
  }
}

class PageSearch extends StatefulWidget {
  const PageSearch({super.key});

  @override
  State<PageSearch> createState() => _PageSearchState();
}

class _PageSearchState extends State<PageSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.green,
          child: const Center(
              child: Text('Search Page', style: TextStyle(fontSize: 24))),
        ),
      ),
    );
  }
}

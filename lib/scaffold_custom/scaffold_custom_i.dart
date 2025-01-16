import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomScaffold(),
    );
  }
}

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({super.key});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> bodys = [
    const PageIndexSatu(),
    const PageGrid(), //PagesIndexDua(),
    const PagesIndexTiga(),
  ];

  List<String> titleAppbar = [
    'Custom Scaffold',
    'Pencarian',
    'Pengaturan',
  ];
  List<String> imagesPath = [
    'assets/images/thai_nature.jpg',
    'assets/images/balon_udara.jpg',
    'assets/images/batu_pantai.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //? Body utama
          Positioned.fill(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey[200], // Background body
                  child: Image.asset(
                    imagesPath[_selectedIndex],
                    fit: BoxFit.cover,
                  ),
                ),
                bodys[_selectedIndex],
              ],
            ),
          ),
          //? AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height / 9,
            child: ClipRRect(
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(20.0),
              //   topRight: Radius.circular(20.0),
              //   bottomLeft: Radius.circular(20.0),
              //   bottomRight: Radius.circular(20.0),
              // ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: AppBar(
                  centerTitle: true,
                  title: Text(
                    titleAppbar[_selectedIndex],
                    style: const TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.blue.withOpacity(0.6),
                ),
              ),
            ),
          ),
          // Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 5.0,
                  ),
                  child: BottomNavigationBar(
                    // type: BottomNavigationBarType.shifting,
                    showUnselectedLabels: false,
                    //showSelectedLabels: false,
                    fixedColor: Colors.amber,
                    backgroundColor: Colors.blue.withOpacity(0.6),
                    currentIndex: _selectedIndex,
                    //selectedItemColor: Colors.deepPurple,
                    unselectedItemColor: Colors.grey,
                    onTap: _onItemTapped,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          size: 30,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.search,
                          size: 30,
                        ),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.settings,
                          size: 30,
                        ),
                        label: 'Settings',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PagesIndexTiga extends StatelessWidget {
  const PagesIndexTiga({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            const Text('Pengaturan'),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                fillColor: Colors.green.shade100.withOpacity(0.6),
                filled: true,
                hintText: 'Cari',
                hintStyle: const TextStyle(color: Colors.white),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            Expanded(child: MixedListWithData())
          ],
        )));
  }
}

class PagesIndexDua extends StatelessWidget {
  const PagesIndexDua({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Cari Artikel',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Saya sedang mempelajari cara mengkostumisasi widget scaffold agar terlihat menarik dengan menggunakan Stack dan Postioned dimana agar saya bisa menambahkan berbagai efek tampilan yang menarik'),
              ),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Saya sedang mempelajari cara mengkostumisasi widget scaffold agar terlihat menarik dengan menggunakan Stack dan Postioned dimana agar saya bisa menambahkan berbagai efek tampilan yang menarik'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageIndexSatu extends StatelessWidget {
  const PageIndexSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 10,
            // ),
            const SizedBox(
              height: 40,
              child: Text(
                'Daftar',
                style: TextStyle(color: Colors.amber),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey.shade200.withOpacity(0.7),
                    elevation: 4,
                    shadowColor: Colors.black45,
                    child: ListTile(
                      title: Text('Ini adalah Card $index'),
                    ),
                  );
                }),
            const SizedBox(
              height: 80,
            ),
            // Container(
            //   height: 80,
            //   child: Text('Lihat Cetak'),
            // )
          ],
        ),
      ),
    );

    // Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     SizedBox(
    //       height: MediaQuery.of(context).size.height / 9,
    //     ),
    //     Expanded(
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: ListView.builder(
    //             // physics: const NeverScrollableScrollPhysics(),
    //             itemCount: 20,
    //             itemBuilder: (context, index) {
    //               return Card(
    //                 color: Colors.grey.shade200.withOpacity(0.7),
    //                 elevation: 4,
    //                 shadowColor: Colors.black45,
    //                 child: ListTile(
    //                   title: Text('Ini adalah Card $index'),
    //                 ),
    //               );
    //             }),
    //       ),
    //     ),
    //   ],
    // );
  }
}

class PageGrid extends StatelessWidget {
  const PageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            const SizedBox(
              height: 60,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Bulan',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Jumlah item per baris
                crossAxisSpacing: 8.0, // Spasi horizontal antar item
                mainAxisSpacing: 8.0, // Spasi vertikal antar item
              ),
              itemCount: 22, // Total jumlah item
              itemBuilder: (context, index) {
                return ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Item',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${index + 1}',
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              padding: const EdgeInsets.all(8.0), // Margin luar untuk GridView
            ),
            const SizedBox(
              height: 80,
            ),
            // Container(
            //   height: 80,
            //   child: Text('Lihat Cetak'),
            // )
          ],
        ),
      ),
    );
  }
}

class MixedListWithData extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {
      "type": "card",
      "content": "This is a card",
    },
    {
      "type": "listTile",
      "title": "This is a ListTile",
      "subtitle": "Subtitle here"
    },
    {
      "type": "container",
      "content": "This is a container",
    },
    {
      "type": "card",
      "content": "Another card",
    },
    {
      "type": "listTile",
      "title": "Another ListTile",
      "subtitle": "Another subtitle"
    },
  ];

  MixedListWithData({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        switch (item['type']) {
          case "card":
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(item['content']),
              ),
            );
          case "listTile":
            return ListTile(
              leading: const Icon(
                Icons.info,
                color: Colors.amber,
              ),
              title: Text(
                item['title'],
                style:
                    TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item['subtitle'],
                style: TextStyle(color: Colors.red),
              ),
            );
          case "container":
            return Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(16.0),
              color: Colors.teal,
              child: Text(
                item['content'],
                style: const TextStyle(color: Colors.white),
              ),
            );
          default:
            return const SizedBox
                .shrink(); // Empty widget for unsupported types
        }
      },
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

class MyWidgetII extends StatefulWidget {
  const MyWidgetII({super.key});

  @override
  State<MyWidgetII> createState() => _MyWidgetIIState();
}

class _MyWidgetIIState extends State<MyWidgetII> {
  int _indexTrpilih = 0;

  void _onItemTapped(int index) {
    setState(() {
      _indexTrpilih = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tinggi = MediaQuery.of(context).size.height;
    final double lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            child: CustomPaint(
              size: Size(lebar, tinggi),
              painter: _GradientPainter(),
            ),
          ),
          Positioned(
              top: tinggi / 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Hai Dunia'),
                      // TextField(
                      //   decoration: InputDecoration(
                      //     enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //         borderSide: BorderSide(
                      //             color: Colors.deepPurple, width: 3)),
                      //     labelText: 'Enter text',
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 100,
                        width: lebar * 0.9,
                        decoration: ShapeDecoration(
                          color: Colors.grey.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Colors.purpleAccent, width: 3),
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "ShapeDecoration",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'My App',
                style: TextStyle(color: Colors.pink.shade900),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(
                      30,
                    )),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: BottomNavigationBar(
                      useLegacyColorScheme: false,
                      selectedItemColor: Colors.amber,
                      unselectedItemColor: Colors.grey,
                      currentIndex: _indexTrpilih,
                      onTap: _onItemTapped,
                      backgroundColor: Colors.cyan.withOpacity(0.5),
                      items: const <BottomNavigationBarItem>[
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
                      ]),
                ),
              ))
        ],
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.blue, Colors.green],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

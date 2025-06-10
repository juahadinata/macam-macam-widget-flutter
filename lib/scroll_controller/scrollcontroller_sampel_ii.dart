import 'package:flutter/material.dart';

// void main() {
//   runApp(const ScrollcontrollerSampelIi());
// }

class ScrollcontrollerSampelIi extends StatefulWidget {
  const ScrollcontrollerSampelIi({super.key});

  @override
  State<ScrollcontrollerSampelIi> createState() =>
      _ScrollcontrollerSampelIiState();
}

class _ScrollcontrollerSampelIiState extends State<ScrollcontrollerSampelIi> {
  late final ScrollController _controller;
  bool isScrolling = false;

  void _handleScrollChange() {
    if (isScrolling != _controller.position.isScrollingNotifier.value) {
      setState(() {
        isScrolling = _controller.position.isScrollingNotifier.value;
      });
    }
  }

  void _handlePositionAttach(ScrollPosition position) {
    // Dari sini, tambahkan pendengar ke ScrollPosition yang diberikan.
    // Di sini isScrollingNotifier akan digunakan untuk menginformasikan kapan pengguliran dimulai
    // dan berhenti serta mengubah warna AppBar sebagai respons.
    position.isScrollingNotifier.addListener(_handleScrollChange);
  }

  void _handlePositionDetach(ScrollPosition position) {
    // Dari sini, tambahkan pendengar ke ScrollPosition yang diberikan.
    // Di sini isScrollingNotifier akan digunakan untuk menginformasikan kapan pengguliran dimulai
    // dan berhenti serta mengubah warna AppBar sebagai respons.
    position.isScrollingNotifier.removeListener(_handleScrollChange);
  }

  @override
  void initState() {
    _controller = ScrollController(
      // Metode ini akan dipanggil sebagai respons terhadap posisi gulir yang dilampirkan atau dilepaskan dari ScrollController ini.
      // Ini terjadi ketika Scrollable dibuat.
      onAttach: _handlePositionAttach,
      onDetach: _handlePositionDetach,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(isScrolling ? 'Scrolling' : 'Not SAcrolling'),
          backgroundColor: isScrolling
              ? Colors.green[800]!.withOpacity(.85)
              : Colors.redAccent[700]!.withOpacity(.85),
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverList.builder(
                itemCount: 50,
                itemBuilder: (_, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 5,
                            )
                          ],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          // ignore: prefer_const_constructors
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20.0),
                          child: Text('Item $index'),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

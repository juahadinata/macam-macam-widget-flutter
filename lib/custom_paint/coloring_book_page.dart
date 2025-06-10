import 'package:flutter/material.dart';

class ColoringBookPage extends StatefulWidget {
  const ColoringBookPage({super.key});

  @override
  State<ColoringBookPage> createState() => _ColoringBookPageState();
}

class _ColoringBookPageState extends State<ColoringBookPage> {
  List<Path> paths = []; // path gambar
  List<Color> colors = []; // warna tiap area
  Color selectedColor = Colors.red;

  @override
  void initState() {
    super.initState();
    _buildPaths();
  }

  void _buildPaths() {
    final path1 = Path()..addRect(Rect.fromLTWH(50, 100, 100, 100));
    final path2 = Path()
      ..addOval(Rect.fromCircle(center: Offset(200, 150), radius: 50));

    paths = [path1, path2];
    colors = List.filled(paths.length, Colors.white); // default putih
  }

  void _handleTap(TapDownDetails details) {
    final touchPoint = details.localPosition;

    for (int i = 0; i < paths.length; i++) {
      if (paths[i].contains(touchPoint)) {
        setState(() {
          colors[i] = selectedColor;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coloring Book')),
      body: GestureDetector(
        onTapDown: _handleTap,
        child: CustomPaint(
          painter: ColoringPainter(paths: paths, colors: colors),
          child: Container(),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...[Colors.red, Colors.green, Colors.blue, Colors.yellow].map(
            (color) => GestureDetector(
              onTap: () => setState(() => selectedColor = color),
              child: Container(
                margin: EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedColor == color
                        ? Colors.black
                        : Colors.transparent,
                    width: 2,
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

class ColoringPainter extends CustomPainter {
  final List<Path> paths;
  final List<Color> colors;

  ColoringPainter({required this.paths, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;

    for (int i = 0; i < paths.length; i++) {
      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = colors[i];

      canvas.drawPath(paths[i], fillPaint); // isi warna
      canvas.drawPath(paths[i], outlinePaint); // outline hitam
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

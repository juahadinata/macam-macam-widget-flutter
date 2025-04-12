import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Contoh Offstage')),
        body: Column(
          children: [
            Offstage(
              offstage: _isHidden,
              child: const Text(
                'Teks ini akan disembunyikan atau ditampilkan',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isHidden = !_isHidden;
                });
              },
              child: Text(_isHidden ? 'Tampilkan' : 'Sembunyikan'),
            ),
          ],
        ),
      ),
    );
  }
}

/* 

Widget Offstage di Flutter digunakan untuk mengontrol apakah suatu widget (child) harus dirender atau tidak, tanpa menghapusnya dari tree widget.

Kegunaan Offstage bagi Child-nya:
Mengontrol Visibilitas tanpa Menghapus dari Widget Tree

Jika offstage: true, maka child tidak akan dirender atau ditampilkan di layar, 
tetapi masih tetap berada di dalam tree widget.

Jika offstage: false, child akan dirender dan terlihat di layar.
Menghemat Performa

Dibandingkan dengan Visibility(visible: false), 
Offstage lebih ringan karena tidak membuat child tetap ada di layout ketika offstage: true.

Child tetap ada dalam widget tree tetapi tidak dihitung dalam layout dan tidak menggambar ulang.
Tetap Dapat Diakses dalam Widget Tree

Meskipun tidak terlihat (offstage: true), child tetap bisa dipanggil dalam kode, misalnya untuk mendapatkan nilai dari TextField yang ada di dalamnya. 
**/
import 'package:flutter/material.dart';

// Contoh ini menunjukkan menampilkan dialog konfirmasi sebelum keluar dari halaman.

// void main() => runApp(const NavigatorPopHandlerApp());

class NavigatorPopHandlerApp extends StatelessWidget {
  const NavigatorPopHandlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const _HomePage(),
        '/dua': (BuildContext context) => const _PageTwo(),
      },
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Halaman Satu'),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/dua');
                },
                child: const Text('Next'))
          ],
        ),
      ),
    );
  }
}

class _PageTwo extends StatefulWidget {
  const _PageTwo();

  @override
  State<_PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<_PageTwo> {
// Menampilkan dialog dan memutuskan menjadi benar ketika pengguna
// telah mengindikasikan bahwa mereka ingin muncul.
// Nilai kembalian null menunjukkan keinginan untuk tidak muncul,
// seperti ketika pengguna telah menutup modal tanpa mengetuk tombol.

  Future<bool?> _tampilDialogKembali() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Tutup untuk menyimpan'),
            content: const Text('Apakah anda yakin meniggalkan halaman ini ?'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge),
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Batal'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Tutup'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Halaman Dua'),
            PopScope(
                canPop: false,
                onPopInvokedWithResult: (bool didPop, Object? result) async {
                  if (didPop) {
                    return;
                  }
                  final bool shouldPop = await _tampilDialogKembali() ?? false;
                  if (context.mounted && shouldPop) {
                    Navigator.pop(context);
                  }
                },
                child: TextButton(
                    onPressed: () async {
                      final bool shouldPop =
                          await _tampilDialogKembali() ?? false;
                      if (context.mounted && shouldPop) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Kembali')))
          ],
        ),
      ),
    );
  }
}

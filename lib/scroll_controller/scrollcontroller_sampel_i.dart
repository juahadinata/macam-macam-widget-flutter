import 'package:flutter/material.dart';

/// Flutter code sample for [ScrollController] & [ScrollNotification].

void main() => runApp(const ScrollNotificationDemo());

class ScrollNotificationDemo extends StatefulWidget {
  const ScrollNotificationDemo({super.key});

  @override
  State<ScrollNotificationDemo> createState() => _ScrollNotificationDemoState();
}

class _ScrollNotificationDemoState extends State<ScrollNotificationDemo> {
  ScrollNotification? _lastNotification;
  late final ScrollController _controller;
  bool _useController = true;

  // Method ini menangani notifikasi dari scrollcontroller
  void _handleControllerNotification() {
    debugPrint('Notified through the scroll controller.');
    // Akses posisi secara langsung melalui pengontrol untuk detail posisi gulir.
  }

  // This method handles the notification from the NotificationListener.
  bool _handleScrollNotification(ScrollNotification notification) {
    debugPrint('Notified through scroll notification.');
    // Posisinya masih dapat diakses melalui pengontrol gulir,
    // namun objek notifikasi memberikan rincian lebih lanjut tentang aktivitas yang sedang terjadi.
    if (_lastNotification.runtimeType != notification.runtimeType) {
      setState(() {
        // panggil SetState untuk merespons perubahan dalam notifikasi gulir.
        _lastNotification = notification;
      });
    }

    // Mengembalikan false memungkinkan notifikasi untuk terus dikirimkan ke pendengar leluhur.
    // Jika kami ingin notifikasi berhenti menggelembung, kembalikan nilai true.
    return false;
  }

  @override
  void initState() {
    _controller = ScrollController();
    if (_useController) {
      // Saat mendengarkan pengguliran melalui ScrollController, panggil `addListener` pada pengontrol.
      _controller.addListener(_handleControllerNotification);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ListView.separated works very similarly to this example with
    // CustomScrollView & SliverList.
    Widget body = CustomScrollView(
      // Provide the scroll controller to the scroll view.
      controller: _controller,
      slivers: <Widget>[
        SliverList.separated(
          itemCount: 50,
          itemBuilder: (_, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20.0,
              ),
              child: Text('Item ${index + 1}'),
            );
          },
          separatorBuilder: (_, __) => const Divider(
            indent: 20,
            endIndent: 20,
            thickness: 2,
          ),
        ),
      ],
    );

    if (!_useController) {
      // Jika kita tidak menggunakan ScrollController untuk mendengarkan pengguliran,
      // mari gunakan NotifikasiListener.
      //
      // Serupa, tetapi dengan pengendali berbeda yang memberikan informasi tentang
      // pengguliran apa yang terjadi.
      body = NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: body,
      );
    }

    return MaterialApp(
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Listening to a ScrollPosition'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (!_useController)
                  Text('Last notification: ${_lastNotification.runtimeType}'),
                if (!_useController) const SizedBox.square(dimension: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('with:'),
                    Radio<bool>(
                      value: true,
                      groupValue: _useController,
                      onChanged: _handleRadioChange,
                    ),
                    const Text('ScrollController'),
                    Radio<bool>(
                      value: false,
                      groupValue: _useController,
                      onChanged: _handleRadioChange,
                    ),
                    const Text('NotificationListener'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: body,
      ),
    );
  }

  void _handleRadioChange(bool? value) {
    if (value == null) {
      return;
    }
    if (value != _useController) {
      setState(() {
        // Tanggapi perubahan pada tombol radio yang dipilih,
        // dan tambahkan/hapus pendengar ke pengontrol gulir.
        _useController = value;
        if (_useController) {
          _controller.addListener(_handleControllerNotification);
        } else {
          _controller.removeListener(_handleControllerNotification);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerNotification);
    super.dispose();
  }
}

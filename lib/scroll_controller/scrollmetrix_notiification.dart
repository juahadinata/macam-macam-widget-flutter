import 'package:flutter/material.dart';

/// Flutter code sample for [ScrollMetricsNotification].
///
/// Contoh ini menunjukkan bagaimana ScrollMetricsNotification dikirimkan ketika windowSize diubah.
/// Tekan FloatingActionButtun untuk menambah ukuran jendela yang dapat digulir.

// void main() {
//   runApp(const ScrollMetricsDemo());
// }

class ScrollMetricsDemo extends StatefulWidget {
  const ScrollMetricsDemo({super.key});

  @override
  State<ScrollMetricsDemo> createState() => _ScrollMetricsDemoState();
}

class _ScrollMetricsDemoState extends State<ScrollMetricsDemo> {
  double windowSize = 200.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ScrollMetrics Demo'),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                windowSize += 10.0;
              });
            }),
        body: NotificationListener<ScrollMetricsNotification>(
          onNotification: (ScrollMetricsNotification notification) {
            ScaffoldMessenger.of(notification.context).showSnackBar(
                const SnackBar(content: Text('Scroll Metrics Changed')));
            return false;
          },
          child: Scrollbar(
              thumbVisibility: true,
              child: SizedBox(
                height: windowSize,
                width: double.infinity,
                child: const SingleChildScrollView(
                  primary: true,
                  child: FlutterLogo(
                    size: 300.0,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

/*
Terakhir, mendengarkan ScrollController atau ScrollPosition tidak akan memberi tahu ketika ScrollMetrics dari posisi gulir tertentu berubah, seperti ketika jendela diubah ukurannya, mengubah dimensi Viewport dan luasan yang dapat digulir yang disebutkan sebelumnya. Untuk mendengarkan perubahan dalam metrik gulir, gunakan NotifikasiListener jenis ScrollMetricsNotification. Jenis notifikasi ini berbeda dengan ScrollNotification, karena tidak dikaitkan dengan aktivitas pengguliran, melainkan dimensi area yang dapat digulir, seperti ukuran jendela.

 */

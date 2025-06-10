import 'package:flutter/material.dart';

///* Contoh ini menunjukkan NavigationBar dalam widget scaffold utama yang digunakan untuk mengontrol visibilitas halaman tujuan.
///
///*Setiap tujuan memiliki scaffold sendiri dan navigator bersarang yang menyediakan navigasi lokal. Contoh NavigationBar memiliki empat widget navigasi navigasi dengan skema warna yang berbeda.
///
///*Callback yang dipilih Ondestinations mengubah indeks tujuan yang dipilih dan menampilkan halaman yang sesuai dengan navigator dan scaffold lokal sendiri - semua di dalam tubuh scaffold utama.
///
///*Halaman tujuan disusun di tempat tumpukan dan switching memudar halaman saat ini dan memudar di yang baru. Destinasi yang tidak terlihat atau menjiwai tetap di luar panggung.
///

///! masih gantung bro...

// void main() {
//   runApp(const MaterialApp(
//     home: Home(),
//   ));
// }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin<Home> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Teal', Icons.home, Colors.teal),
    Destination(1, 'Cyan', Icons.business, Colors.cyan),
    Destination(2, 'Orange', Icons.school, Colors.orange),
    Destination(3, 'Blue', Icons.flight, Colors.blue),
  ];
  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<GlobalKey> destinationKeys;
  late final List<AnimationController> destinationFaders;
  late final List<Widget> destinationVies;
  int selectedIndex = 0;

  AnimationController buildFaderController() {
    return AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addStatusListener((AnimationStatus status) {
        if (status.isDismissed) {
          setState(() {});
        }
      });
  }

  @override
  void initState() {
    super.initState();

    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
        allDestinations.length, (int index) => GlobalKey()).toList();
    destinationFaders = List<AnimationController>.generate(
      allDestinations.length,
      (int index) => buildFaderController(),
    ).toList();
    destinationFaders[selectedIndex].value = 1.0;

    final CurveTween tween = CurveTween(curve: Curves.fastOutSlowIn);
    destinationVies = allDestinations.map<Widget>(
      (Destination destination) {
        return FadeTransition(
          opacity: destinationFaders[destination.index].drive(tween),
          child: DestinationView(
            destination: destination,
            navigatorKey: navigatorKeys[destination.index],
          ),
        );
      },
    ).toList();
  }

  @override
  void dispose() {
    for (final AnimationController controller in destinationFaders) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        final NavigatorState navigator =
            navigatorKeys[selectedIndex].currentState!;
        navigator.pop();
      },
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: allDestinations.map((Destination destination) {
              final int index = destination.index;
              final Widget view = destinationVies[index];
              if (index == selectedIndex) {
                destinationFaders[index].forward();
                return Offstage(offstage: false, child: view);
              } else {
                destinationFaders[index].reverse();
                if (destinationFaders[index].isAnimating) {
                  return IgnorePointer(child: view);
                }
                return Offstage(child: view);
              }
            }).toList(),
          ),
        ),
        bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: allDestinations
                .map<NavigationDestination>((Destination destination) {
              return NavigationDestination(
                icon: Icon(destination.icon, color: destination.color),
                label: destination.title,
              );
            }).toList()),
      ),
    );
  }
}

class Destination {
  const Destination(this.index, this.title, this.icon, this.color);
  final int index;
  final String title;
  final IconData icon;
  final MaterialColor color;
}

class RootPage extends StatelessWidget {
  const RootPage({super.key, required this.destination});
  final Destination destination;

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: Text('${destination.title} AlertDialog'),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle headLineSmall = Theme.of(context).textTheme.headlineSmall!;
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: destination.color,
      foregroundColor: Colors.white,
      visualDensity: VisualDensity.comfortable,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      textStyle: headLineSmall,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('${destination.title} RootPage - /'),
        backgroundColor: destination.color,
        foregroundColor: Colors.white,
      ),
      backgroundColor: destination.color[50],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.pushNamed(context, '/list');
              },
              child: const Text('Push /list'),
            ),
            ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    useRootNavigator: false,
                    builder: _buildDialog,
                  );
                },
                child: const Text('Local Dialog')),
            ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  showDialog(
                      context: context,
                      useRootNavigator: true,
                      builder: _buildDialog);
                },
                child: const Text('Root Dialog')),
            Builder(builder: (BuildContext context) {
              return ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    showBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            width: double.infinity,
                            child: Text(
                              '${destination.title} BottomSheet\n'
                              'Tap the back button to dismiss',
                              style: headLineSmall,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          );
                        });
                  },
                  child: const Text('Local BottomSheet'));
            })
          ],
        ),
      ),
    );
  }
}

///?  Widget yang menampilkan daftar item dengan tombol untuk navigasi ke halaman teks.
class ListPage extends StatelessWidget {
  const ListPage({super.key, required this.destination});
  final Destination destination;

  @override
  Widget build(BuildContext context) {
    const int itemCount = 50;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: colorScheme.onSurface.withOpacity(0.12),
        ),
      ),
      foregroundColor: destination.color,
      fixedSize: const Size.fromHeight(64),
      textStyle: Theme.of(context).textTheme.headlineSmall,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('${destination.title} ListPage - /list'),
        backgroundColor: destination.color,
        foregroundColor: Colors.white,
      ),
      backgroundColor: destination.color[50],
      body: SizedBox.expand(
        child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: OutlinedButton(
                    style: buttonStyle.copyWith(
                      backgroundColor: WidgetStatePropertyAll<Color>(Color.lerp(
                          destination.color[100],
                          Colors.white,
                          index / itemCount)!),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/text');
                    },
                    child: Text('Push /text [$index]')),
              );
            }),
      ),
    );
  }
}

///? Widget yang menampilkan halaman text dengan TextField
class TextPage extends StatefulWidget {
  const TextPage({super.key, required this.destination});
  final Destination destination;

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  ///? mengontrol input text
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: 'Sample Text');
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.destination.title} TextPage - /list/text'),
        backgroundColor: widget.destination.color,
        foregroundColor: Colors.white,
      ),
      backgroundColor: widget.destination.color[50],
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.center,
        child: TextField(
          controller: textController,
          style: theme.primaryTextTheme.headlineMedium?.copyWith(
            color: widget.destination.color,
          ),
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
            color: widget.destination.color,
            width: 3.0,
          ))),
        ),
      ),
    );
  }
}

///? Widget yang mengelola navigasi untuk setiap destinasi
class DestinationView extends StatefulWidget {
  const DestinationView({
    super.key,
    required this.destination,
    required this.navigatorKey,
  });
  final Destination destination;
  final Key navigatorKey;

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    ///? Navigator : widget yang mengelola stack navigasi
    return Navigator(
      ///? menggunakan navigatorKey yang diterima dari widget
      key: widget.navigatorKey,

      ///? onGenerateRoute: Menghasilkan rute berdasarkan nama rute yang diberikan.
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              ///? menggunakan switch-case untuk menetukan halaman yang akan ditampilkan
              switch (settings.name) {
                ///* Jika nama rute adalah '/', tampilkan RootPage dengan destination yang sesuai
                case '/':
                  return RootPage(destination: widget.destination);

                ///* Jika nama rute adalah '/list', tampilkan ListPage dengan destination yang sesuai
                case '/list':
                  return ListPage(destination: widget.destination);

                ///* Jika nama rute adalah '/text', tampilkan TextPage dengan destination yang sesuai
                case '/text':
                  return TextPage(destination: widget.destination);
              }
              // Jika tidak ada case yang cocok,
              // lakukan assert (biasanya menandakan kesalahan pengkodean)
              assert(false);
              // Mengembalikan widget kosong sebagai fallback
              // (tidak akan pernah terjadi jika semua rute sudah didefinisikan)
              return const SizedBox();
            });
      },
    );
  }
}

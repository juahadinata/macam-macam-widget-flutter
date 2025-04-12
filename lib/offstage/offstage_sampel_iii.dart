import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // State global untuk title
  /* 
      Penjelasan
      ValueNotifier<String> digunakan untuk menyimpan judul AppBar 
      yang bisa diperbarui dari halaman lain.

      ValueListenableBuilder<String> digunakan dalam AppBar 
      agar otomatis update ketika nilainya berubah.

      Tiap halaman menerima titleNotifier dan bisa mengubahnya 
      dengan titleNotifier.value = "New Title";.

  **/
  final ValueNotifier<String> _appBarTitle = ValueNotifier<String>("Home");

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeScreen(titleNotifier: _appBarTitle),
      ProfileScreen(titleNotifier: _appBarTitle),
      SettingsScreen(titleNotifier: _appBarTitle),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<String>(
          valueListenable: _appBarTitle,
          builder: (context, title, child) {
            return Text(title);
          },
        ),
      ),
      body: Stack(
        children: List.generate(
          _pages.length,
          (index) => Offstage(
            offstage: _selectedIndex != index,
            child: _pages[index],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final ValueNotifier<String> titleNotifier;

  const HomeScreen({super.key, required this.titleNotifier});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          titleNotifier.value = "Home - Updated!";
        },
        child: const Text("Update AppBar Title"),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final ValueNotifier<String> titleNotifier;

  const ProfileScreen({super.key, required this.titleNotifier});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          titleNotifier.value = "Profile - Updated!";
        },
        child: const Text("Update AppBar Title"),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final ValueNotifier<String> titleNotifier;

  const SettingsScreen({super.key, required this.titleNotifier});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          titleNotifier.value = "Settings - Updated!";
        },
        child: const Text("Update AppBar Title"),
      ),
    );
  }
}

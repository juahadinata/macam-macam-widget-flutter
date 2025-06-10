import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Page'));
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Page'));
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings Page'));
  }
}

/*
Jika kamu ingin membuat NavigationBar dengan tampilan yang persisten, 
maka Offstage adalah pilihan yang cocok dibandingkan 
dengan mengganti seluruh halaman menggunakan Navigator.push().

Mengapa Offstage Cocok untuk NavigationBar?
Tetap Mempertahankan State

Jika menggunakan Navigator.push(), setiap kali berpindah halaman, 
widget akan dibangun ulang dari awal.

Dengan Offstage, widget tetap ada dalam tree, 
sehingga state (misalnya input di TextField atau posisi scroll) tidak hilang.

Performa Lebih Baik

Offstage hanya menyembunyikan tampilan tetapi tidak membuang widget dari tree.
Navigasi antar tab menjadi lebih cepat karena widget tidak perlu dibuat ulang 
setiap kali pengguna berpindah tab.

Menghindari Masalah dengan Animasi Navigasi

Jika menggunakan Navigator.push(), berpindah halaman akan menggunakan animasi transisi, 
yang mungkin tidak diinginkan dalam bottom navigation.

Offstage tidak menggunakan animasi transisi sehingga berpindah antar tab terasa lebih instan.
**/
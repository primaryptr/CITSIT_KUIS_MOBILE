import 'package:flutter/material.dart';

import 'home_page.dart';
import 'profile_page.dart';

// STATEFUL: tab yang dipilih (selectedIndex) berubah-ubah
class MainPage extends StatefulWidget {
  // >>> TEMPLATE 2 (KIRIM USERNAME ANTAR HALAMAN) - MULAI
  final String username;

  const MainPage({super.key, required this.username});
  // <<< TEMPLATE 2 (KIRIM USERNAME ANTAR HALAMAN) - SELESAI

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0; // 0 = Menu, 1 = Profil

  @override
  Widget build(BuildContext context) {
    // >>> TEMPLATE 2 (KIRIM USERNAME ANTAR HALAMAN) - MULAI
    // dibuat di dalam build() karena butuh widget.username
    final pages = [
      HomePage(username: widget.username),
      ProfilePage(username: widget.username),
    ];
    // <<< TEMPLATE 2 (KIRIM USERNAME ANTAR HALAMAN) - SELESAI

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

import 'package:belajar_login_firebase/daftar.dart';
import 'package:belajar_login_firebase/login.dart';
import 'package:belajar_login_firebase/lupa.dart';
import 'package:flutter/material.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _mulaiIndex = 0;

  // list halaman
  static const List<Widget> _halaman = [
    Login(),
    Daftar(),
    Lupa(),
  ];

  void _saatIndexDitekan(int indexnya) {
    setState(() {
      _mulaiIndex = indexnya;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _halaman[_mulaiIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _mulaiIndex,
        onTap: _saatIndexDitekan,
      ),
    );
  }
}

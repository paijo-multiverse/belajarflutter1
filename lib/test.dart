import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _indexDipilih = 0;
  void _stateIndex(int index) {
    setState(() {
      _indexDipilih = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.import_contacts), label: 'Index 1'),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_outlined), label: 'ikan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_ic_call_outlined), label: 'telpon'),
        ],
        currentIndex: _indexDipilih,
        onTap: _stateIndex,
      ),
    );
  }
}

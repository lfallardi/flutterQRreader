import 'package:flutter/material.dart';
import 'package:qr_lector/src/pages/direcciones_page.dart';
import 'package:qr_lector/src/pages/mapa_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lector QR'),
        actions: [
          IconButton(
            icon: Icon ( Icons.delete_forever ),
            onPressed: () {}) 
        ],
      ),
      body: _callPage(_currentIndex),
      bottomNavigationBar: _crearBottomNavigation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.filter_center_focus ),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _callPage(int paginaActual) {

    switch (paginaActual) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default:
        return MapasPage();
    }

  }

  _crearBottomNavigation() {

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon( Icons.map ),
          title: Text('Mapa'),
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.directions ),
          title: Text('Direcciones'),
        ),
      ],
    );

  }

  _scanQR() {
    print('ESCANEO CODIGO QR');
  }
}
import 'package:flutter/material.dart';

import 'package:qr_readerapp/src/pages/home_page.dart';
import 'package:qr_readerapp/src/pages/mapa_page.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr Reader',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'mapa' : (BuildContext context) => MapaPage(),
      }, 
      theme: ThemeData(
        primaryColor: Colors.blueGrey
      ),
    );
  }
}
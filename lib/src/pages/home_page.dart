import 'dart:io';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_readerapp/src/bloc/scans_bloc.dart';
import 'package:qr_readerapp/src/providers/db_provider.dart';
import 'package:qr_readerapp/src/utils/utils.dart' as utils;

import 'direcciones_page.dart';
import 'mapas_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(icon: Icon(Icons.delete_forever), onPressed: scansBloc.borrarScansTodos,),
           
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: ()=> _scanQR(context),
      ),
    );
  }

  _scanQR(BuildContext context) async{
    // https://luissoriano.herokuapp.com/

    dynamic futureString;

    try{
      futureString = await BarcodeScanner.scan();
      
    }catch(e){
      futureString = e.String();
    }

    print('Future String: ${futureString.rawContent}');

    if(futureString != null){

      final scan = ScanModel(valor: futureString.rawContent);
      scansBloc.agregarScan(scan);
      
      /*final scan2 = ScanModel(valor: 'geo:40.724233047051705,-74.007');
      scansBloc.agregarScan(scan2);*/

      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds: 750), (){
          utils.abrirURL(context,scan);
        });
      }else{
        utils.abrirURL(context,scan);
      }
    }

  }

  Widget _crearBottomNavigationBar() {

    return BottomNavigationBar(
      currentIndex: currentIndex,
      items:[
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
        BottomNavigationBarItem(icon: Icon(Icons.brightness_5), title: Text('Direcciones')),

      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {
          
        });
       },
    );
  }

  Widget _callPage(int paginaActual) {

    switch(paginaActual){
      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default:
        return MapasPage();

    }

  }
}
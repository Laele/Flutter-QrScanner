import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_readerapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();

  String tipoMapa = 'outdoors-v11';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar:AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.my_location) ,onPressed: (){ 
            map.move(scan.getLatIng(), 15);
          },)
        ]
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {

    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center:scan.getLatIng(),
        zoom: 10
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa(){

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : 'pk.eyJ1IjoibGFlbGUiLCJhIjoiY2tnaWZvam1kMGhnODJ4bGZpdjExaXYxcSJ9.q-k1W5BOqljUySOSOjP4Pw',
        'id' : 'mapbox/$tipoMapa'
        // streets, dark, light, outdoors, satellite
      }
    );
  }

  _crearMarcadores(ScanModel scan) {

    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 130.0,
          height: 130.0,
          point: scan.getLatIng(),
          builder: (context) => Container(
            child: Icon(Icons.location_on, size: 65.0, color: Theme.of(context).primaryColor)),
        )
      ]
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {

    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){ 

        if(tipoMapa == 'streets-v11'){
          tipoMapa = 'dark-v10';
        }else if(tipoMapa == 'dark-v10'){
          tipoMapa = 'outdoors-v11';
        }else if(tipoMapa == 'outdoors-v11'){
          tipoMapa = 'satellite-v9';
        }else{
          tipoMapa = 'streets-v11';
        }
        setState(() {
          
        });
      }
    );
  }
}
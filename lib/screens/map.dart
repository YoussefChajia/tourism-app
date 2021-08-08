import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Carte extends StatefulWidget {
  @override
  _CarteState createState() => _CarteState();
}

class _CarteState extends State<Carte> {

  CameraPosition hassanPosition = CameraPosition(target: LatLng(34.024317, -6.822659), zoom: 10);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        child: Container(
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: hassanPosition,
          ),
        ),
        onTap: (){
          return Map();
        },
      ),
    );
  }
}
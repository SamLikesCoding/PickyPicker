// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pickypicker/location.dart';

void main() {
  runApp(const entryPoint());
}

class entryPoint extends StatelessWidget {
  const entryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapApp(),
    );
  }
}

class MapApp extends StatefulWidget {
  const MapApp({Key? key}) : super(key: key);

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  final MapController _controller = MapController();
  Position? position;
  getPlace() async => position = await whereAmI();
  @override
  Widget build(BuildContext context) {
    getPlace();
    return Scaffold(
      body: FlutterMap(
        mapController: _controller,
        options: MapOptions(
          center: LatLng(position!.latitude, position!.longitude),
        ),
        layers: [
          TileLayerOptions(
            minZoom: 1,
            maxZoom: 18,
            backgroundColor: Colors.black,
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
